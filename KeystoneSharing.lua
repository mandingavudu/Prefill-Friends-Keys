local _, PFK = ...

local ADDON_MESSAGE_PREFIX = "PFKeys"
local keystones, contacts, lastReplyTimes = {}, {}, {}
local guildMembers = {}
local lastRequestTime = -math.huge

local function GetFullCharacterName(name, realm)
    if not name then
        return
    end
    if name:find("-", 1, true) then
        return name
    end
    return name .. "-" .. (realm or GetNormalizedRealmName()):gsub("%s", "")
end

local function GetPlayerFullName()
    return GetFullCharacterName(UnitFullName("player"))
end

local function NotifyKeystoneUpdate()
    if PFK.UpdateKeyList then
        PFK.UpdateKeyList()
    end
end

function PFK.StoreKeystone(owner, challengeMapID, level, source)
    if not owner or not challengeMapID or not level then
        return
    end
    if challengeMapID < 0 or level < 0 or challengeMapID % 1 ~= 0 or level % 1 ~= 0 then
        return
    end
    if challengeMapID == 0 and level == 0 then
        keystones[owner] = nil
    elseif challengeMapID > 0 and level > 0 and level <= 999
        and C_ChallengeMode.GetMapUIInfo(challengeMapID) then
        keystones[owner] = { owner = owner, challengeMapID = challengeMapID, level = level,
            source = source, updated = GetTime() }
    else
        return
    end
    NotifyKeystoneUpdate()
end

local function GetOwnedKeystone()
    local challengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID() or 0
    local level = C_MythicPlus.GetOwnedKeystoneLevel() or 0
    if challengeMapID == 0 or level == 0 then
        return 0, 0
    end
    return challengeMapID, level
end

local function GetKeystonePayload()
    local challengeMapID, level = GetOwnedKeystone()
    return string.format("1:%d:%d", challengeMapID, level)
end

function PFK.UpdateOwnKeystone()
    local challengeMapID, level = GetOwnedKeystone()
    PFK.StoreKeystone(GetPlayerFullName(), challengeMapID, level, PFK.L.SOURCE_SELF)
end

local function GetGroupChannel()
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        return "INSTANCE_CHAT"
    end
    if IsInRaid() then
        return "RAID"
    end
    if IsInGroup() then
        return "PARTY"
    end
end

local function IsGroupMember(name)
    if name == GetPlayerFullName() then
        return true
    end
    local prefix = IsInRaid() and "raid" or "party"
    for memberIndex = 1, GetNumGroupMembers() do
        if GetFullCharacterName(UnitFullName(prefix .. memberIndex)) == name then
            return true
        end
    end
    return false
end

function PFK.UpdateContacts()
    wipe(contacts)
    wipe(guildMembers)
    if IsInGuild() then
        for memberIndex = 1, GetNumGuildMembers() do
            local name, _, _, _, _, _, _, _, online = GetGuildRosterInfo(memberIndex)
            if name and online then
                guildMembers[GetFullCharacterName(name)] = true
            end
        end
    end
    local friendCount = BNGetNumFriends()
    for friendIndex = 1, friendCount do
        for accountIndex = 1, C_BattleNet.GetFriendNumGameAccounts(friendIndex) do
            local info = C_BattleNet.GetFriendGameAccountInfo(friendIndex, accountIndex)
            if info and info.isOnline and info.clientProgram == "WoW"
                and info.wowProjectID == WOW_PROJECT_ID and info.isInCurrentRegion
                and info.characterName and info.realmName then
                contacts["bn:" .. info.gameAccountID] = {
                    owner = GetFullCharacterName(info.characterName, info.realmName),
                    target = info.gameAccountID, battleNet = true,
                }
            end
        end
    end
    for friendIndex = 1, C_FriendList.GetNumFriends() do
        local info = C_FriendList.GetFriendInfoByIndex(friendIndex)
        if info and info.connected and info.name then
            local owner = GetFullCharacterName(info.name)
            contacts[owner] = { owner = owner, target = owner }
        end
    end
end

local function SendContactMessage(contact, data)
    if contact.battleNet then
        C_BattleNet.SendGameData(contact.target, ADDON_MESSAGE_PREFIX, data)
    else
        C_ChatInfo.SendAddonMessage(ADDON_MESSAGE_PREFIX, data, "WHISPER", contact.target)
    end
end

function PFK.RequestKeystones()
    if InCombatLockdown() or GetTime() - lastRequestTime < 10 then
        return
    end
    lastRequestTime = GetTime()
    PFK.UpdateContacts()
    PFK.UpdateOwnKeystone()
    if IsInGuild() then
        C_GuildInfo.GuildRoster()
        C_ChatInfo.SendAddonMessage(ADDON_MESSAGE_PREFIX, "R", "GUILD")
        C_ChatInfo.SendAddonMessage("LibKS", "R", "GUILD")
    end
    local channel = GetGroupChannel()
    if channel then
        C_ChatInfo.SendAddonMessage(ADDON_MESSAGE_PREFIX, "R", channel)
        -- Interoperate with party members running BigWigs/other LibKeystone addons.
        if channel == "PARTY" then
            C_ChatInfo.SendAddonMessage("LibKS", "R", channel)
        end
    end
    local queue = {}
    for _, contact in pairs(contacts) do queue[#queue + 1] = contact end
    for contactIndex, contact in ipairs(queue) do
        local target = contact
        C_Timer.After(contactIndex * 0.2, function()
            if not InCombatLockdown() then
                SendContactMessage(target, "R")
            end
        end)
    end
end

function PFK.ReceiveKeystoneMessage(event, prefix, data, channel, sender)
    if InCombatLockdown() or type(data) ~= "string" or #data > 64 then
        return
    end
    if prefix ~= ADDON_MESSAGE_PREFIX and prefix ~= "LibKS" then
        return
    end
    local contact, owner
    if event == "BN_CHAT_MSG_ADDON" then
        if prefix ~= ADDON_MESSAGE_PREFIX then
            return
        end
        contact = contacts["bn:" .. tostring(sender)]
        if not contact then
            PFK.UpdateContacts()
            contact = contacts["bn:" .. tostring(sender)]
        end
        if not contact then
            return
        end
        owner = contact.owner
    else
        owner = GetFullCharacterName(sender)
        if channel == "WHISPER" then
            contact = contacts[owner]
            if not contact or prefix ~= ADDON_MESSAGE_PREFIX then
                return
            end
        elseif channel == "GUILD" then
            if not IsInGuild() then
                return
            end
            -- Guild-channel delivery establishes membership even before the roster arrives.
            guildMembers[owner] = true
        elseif channel ~= "PARTY" and channel ~= "RAID" and channel ~= "INSTANCE_CHAT" then
            return
        elseif not IsGroupMember(owner) then
            return
        end
    end
    if owner == GetPlayerFullName() then
        return
    end
    if data == "R" then
        if prefix ~= ADDON_MESSAGE_PREFIX then
            return
        end
        local target = contact and ("contact:" .. tostring(contact.target)) or channel
        if GetTime() - (lastReplyTimes[target] or -math.huge) < 5 then
            return
        end
        lastReplyTimes[target] = GetTime()
        if contact then SendContactMessage(contact, GetKeystonePayload())
        else C_ChatInfo.SendAddonMessage(ADDON_MESSAGE_PREFIX, GetKeystonePayload(), channel) end
        return
    end
    local challengeMapID, level
    if prefix == ADDON_MESSAGE_PREFIX then
        challengeMapID, level = data:match("^1:(%d+):(%d+)$")
    else
        level, challengeMapID = data:match("^(%d+),(%d+),%d+$")
    end
    PFK.StoreKeystone(owner, tonumber(challengeMapID), tonumber(level), contact and PFK.L.SOURCE_FRIEND or PFK.L.SOURCE_PARTY)
end

function PFK.GetSortedKeystones()
    local sortedKeystones, online, battleNet = {}, {}, {}
    for _, contact in pairs(contacts) do
        online[contact.owner] = true
        if contact.battleNet then
            battleNet[contact.owner] = true
        end
    end
    for owner, keystone in pairs(keystones) do
        if GetTime() - keystone.updated >= PFK.KEY_EXPIRATION_SECONDS then
            keystones[owner] = nil
        else
            local priority, source, chatColor
            if owner == GetPlayerFullName() then
                priority, source = 1, PFK.L.SOURCE_SELF
            elseif IsGroupMember(owner) then
                priority, source, chatColor = 2, PFK.L.SOURCE_PARTY, "PARTY"
            elseif guildMembers[owner] then
                priority, source, chatColor = 3, PFK.L.SOURCE_GUILD, "GUILD"
            elseif battleNet[owner] then
                priority, source, chatColor = 4, PFK.L.SOURCE_BATTLENET, "BN_WHISPER"
            elseif online[owner] then
                priority, source = 5, PFK.L.SOURCE_FRIEND
            end
            if priority then
                keystone.priority, keystone.source, keystone.chatColor = priority, source, chatColor
                sortedKeystones[#sortedKeystones + 1] = keystone
            end
        end
    end
    table.sort(sortedKeystones, function(a, b)
        if a.priority ~= b.priority then
            return a.priority < b.priority
        end
        if a.level ~= b.level then
            return a.level > b.level
        end
        return a.owner < b.owner
    end)
    return sortedKeystones
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:RegisterEvent("BN_CHAT_MSG_ADDON")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("BN_FRIEND_INFO_CHANGED")
frame:RegisterEvent("FRIENDLIST_UPDATE")
frame:RegisterEvent("GUILD_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_GUILD_UPDATE")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE")
frame:SetScript("OnEvent", function(_, event, ...)
    if event == "CHAT_MSG_ADDON" or event == "BN_CHAT_MSG_ADDON" then
        PFK.ReceiveKeystoneMessage(event, ...)
    elseif event == "ADDON_LOADED" then
        if PFK.InitializeKeyList then
            PFK.InitializeKeyList()
        end
    elseif event == "PLAYER_LOGIN" then
        C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MESSAGE_PREFIX)
        C_ChatInfo.RegisterAddonMessagePrefix("LibKS")
        C_MythicPlus.RequestMapInfo()
        PFK.UpdateContacts()
        PFK.UpdateOwnKeystone()
        PFK.InitializeKeyList()
    elseif not InCombatLockdown() then
        PFK.UpdateContacts()
        PFK.UpdateOwnKeystone()
        if PFK.KeyListFrame and PFK.KeyListFrame:IsShown() then
            PFK.RequestKeystones()
        end
    end
end)
