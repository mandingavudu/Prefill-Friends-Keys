local _, PFK = ...

local keyListFrame, statusText, titleEditBox, scrollContent, scrollFrame
local keyButtons = {}
local panelOffsetX, panelOffsetY

local function UpdatePosition()
    local x, y = 8, 0
    local profileTooltip = _G.RaiderIO_ProfileTooltip
    if profileTooltip and profileTooltip:IsShown() then
        local scale = LFGListFrame:GetEffectiveScale()
        local ratio = profileTooltip:GetEffectiveScale() / scale
        local left, right, top = LFGListFrame:GetLeft(), LFGListFrame:GetRight(), LFGListFrame:GetTop()
        local profileLeft, profileRight, profileTop, profileBottom = profileTooltip:GetLeft(), profileTooltip:GetRight(), profileTooltip:GetTop(), profileTooltip:GetBottom()
        if left and right and top and profileLeft and profileRight and profileTop and profileBottom then
            profileLeft, profileRight = profileLeft * ratio, profileRight * ratio
            profileTop, profileBottom = profileTop * ratio, profileBottom * ratio
            local width, height = keyListFrame:GetWidth(), keyListFrame:GetHeight()
            if right + x < profileRight + 8 and right + x + width > profileLeft - 8
                and top > profileBottom - 8 and top - height < profileTop + 8 then
                x = profileRight + 8 - right
                local screenRatio = UIParent:GetEffectiveScale() / scale
                if right + x + width > UIParent:GetRight() * screenRatio then
                    if left - width - 8 >= UIParent:GetLeft() * screenRatio and left <= profileLeft then
                        x = left - width - 8 - right
                    else
                        x, y = 8, profileBottom - 8 - top
                    end
                end
            end
        end
    end
    if x ~= panelOffsetX or y ~= panelOffsetY then
        keyListFrame:ClearAllPoints()
        keyListFrame:SetPoint("TOPLEFT", LFGListFrame, "TOPRIGHT", x, y)
        panelOffsetX, panelOffsetY = x, y
    end
end

local function CreateLabel(parent, text, font, x, y, width)
    local label = parent:CreateFontString(nil, "OVERLAY", font)
    label:SetPoint("TOPLEFT", x, y)
    label:SetWidth(width)
    label:SetJustifyH("LEFT")
    label:SetText(text)
    return label
end

local function SelectKeystone(keystone)
    if InCombatLockdown() then
        statusText:SetText(PFK.L.SELECT_OUTSIDE_COMBAT)
        return
    end
    local entry = LFGListFrame.EntryCreation
    if not entry:IsShown() or entry.editMode then
        statusText:SetText(PFK.L.OPEN_GROUP_CREATION)
        return
    end
    if GetTime() - keystone.updated >= PFK.KEY_EXPIRATION_SECONDS then
        statusText:SetText(PFK.L.KEY_EXPIRED)
        PFK.UpdateKeyList()
        return
    end
    local activityID, info = PFK.FindMythicPlusActivity(keystone.challengeMapID)
    if not activityID then
        statusText:SetText(PFK.L.ACTIVITY_UNAVAILABLE)
        return
    end
    -- Use Blizzard's normal activity selection; never write the protected title box.
    LFGListEntryCreation_Select(entry, 0, 2, info.groupFinderActivityGroupID, activityID)
    LFGListEntryCreation_OnPlayStyleSelectedInternal(entry, PFK.GetDefaultPlaystyle())
    entry.PlayStyleDropdown:GenerateMenu()
    titleEditBox:SetText("+" .. keystone.level)
    titleEditBox:SetFocus()
    titleEditBox:HighlightText()
    statusText:SetText(PFK.L.KEY_SELECTED)
end

function PFK.UpdateKeyList()
    if not keyListFrame or not keyListFrame:IsShown() then
        return
    end
    local keystones = PFK.GetSortedKeystones()
    for keyIndex, keystone in ipairs(keystones) do
        local button = keyButtons[keyIndex]
        if not button then
            button = CreateFrame("Button", nil, scrollContent)
            button:SetSize(236, 44)
            button:SetPoint("TOPLEFT", 0, -(keyIndex - 1) * 46)
            button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
            button.DungeonText = CreateLabel(button, "", "GameFontHighlight", 6, -5, 224)
            button.OwnerText = CreateLabel(button, "", "GameFontDisableSmall", 6, -25, 224)
            button:SetScript("OnClick", function(self) SelectKeystone(self.keystone) end)
            button:SetScript("OnEnter", function(self)
                local keystone = self.keystone
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(keystone.owner)
                GameTooltip:AddLine(C_ChallengeMode.GetMapUIInfo(keystone.challengeMapID) .. " +" .. keystone.level, 1, 1, 1)
                GameTooltip:AddLine(string.format(PFK.L.KEY_RECEIVED, keystone.source, math.floor(GetTime() - keystone.updated)))
                GameTooltip:AddLine(PFK.L.PREPARE_LISTING, 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            button:SetScript("OnLeave", function() GameTooltip:Hide() end)
            keyButtons[keyIndex] = button
        end
        button.keystone = keystone
        button.DungeonText:SetText("+" .. keystone.level .. "  " .. (C_ChallengeMode.GetMapUIInfo(keystone.challengeMapID) or PFK.L.UNKNOWN_DUNGEON))
        local color = keystone.chatColor and ChatTypeInfo[keystone.chatColor]
            or (keystone.priority == 1 and NORMAL_FONT_COLOR or HIGHLIGHT_FONT_COLOR)
        button.DungeonText:SetTextColor(color.r, color.g, color.b)
        button.OwnerText:SetText(keystone.owner .. "  (" .. keystone.source .. ")")
        button:Show()
    end
    for keyIndex = #keystones + 1, #keyButtons do keyButtons[keyIndex]:Hide() end
    scrollContent:SetHeight(math.max(1, #keystones * 46))
    scrollFrame:UpdateScrollChildRect()
    scrollFrame.ScrollBar:SetValue(math.min(scrollFrame:GetVerticalScroll(), math.max(0, #keystones * 46 - scrollFrame:GetHeight())))
    keyListFrame.EmptyText:SetShown(#keystones == 0)
end

function PFK.InitializeKeyList()
    if keyListFrame or not LFGListFrame or not LFGListFrame.EntryCreation then
        return
    end
    keyListFrame = CreateFrame("Frame", "PrefillFriendsKeysPanel", LFGListFrame, "BackdropTemplate")
    PFK.KeyListFrame = keyListFrame
    keyListFrame:SetSize(280, 440)
    UpdatePosition()
    keyListFrame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16,
        edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } })
    keyListFrame:EnableMouse(true)
    keyListFrame:Hide()
    local headingText = CreateLabel(keyListFrame, PFK.L.AVAILABLE_KEYS, "GameFontNormal", 14, -14, 170)
    local refreshButton = CreateFrame("Button", nil, keyListFrame, "UIPanelButtonTemplate")
    refreshButton:SetSize(70, 22)
    refreshButton:SetPoint("TOPRIGHT", -12, -10)
    refreshButton:SetText(PFK.L.REFRESH)
    local refreshWidth = math.max(70, refreshButton:GetFontString():GetStringWidth() + 20)
    refreshButton:SetWidth(refreshWidth)
    headingText:SetWidth(math.max(1, 246 - refreshWidth))
    refreshButton:SetScript("OnClick", function()
        if InCombatLockdown() then
            statusText:SetText(PFK.L.REFRESH_OUTSIDE_COMBAT)
            return
        end
        titleEditBox:ClearFocus()
        PFK.RequestKeystones()
        statusText:SetText(PFK.L.REQUESTING_KEYS)
    end)

    scrollFrame = CreateFrame("ScrollFrame", nil, keyListFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 12, -44)
    scrollFrame:SetSize(236, 230)
    scrollFrame:SetClipsChildren(true)
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        self.ScrollBar:SetValue(math.max(0, math.min(self:GetVerticalScrollRange(), self:GetVerticalScroll() - delta * 46)))
    end)
    scrollContent = CreateFrame("Frame", nil, scrollFrame)
    scrollContent:SetSize(236, 1)
    scrollFrame:SetScrollChild(scrollContent)
    keyListFrame.EmptyText = CreateLabel(keyListFrame, PFK.L.NO_SHARED_KEYS,
        "GameFontHighlightSmall", 18, -60, 240)
    CreateLabel(keyListFrame, PFK.L.TITLE_LEVEL, "GameFontNormalSmall", 14, -320, 250)
    titleEditBox = CreateFrame("EditBox", nil, keyListFrame, "InputBoxTemplate")
    titleEditBox:SetSize(240, 24)
    titleEditBox:SetPoint("TOPLEFT", 20, -340)
    titleEditBox:SetAutoFocus(false)
    titleEditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    titleEditBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    statusText = CreateLabel(keyListFrame, PFK.L.SELECT_KEY_HINT,
        "GameFontHighlightSmall", 14, -376, 250)

    local refreshElapsed, positionElapsed = 0, 0
    keyListFrame:SetScript("OnUpdate", function(_, delta)
        refreshElapsed = refreshElapsed + delta
        positionElapsed = positionElapsed + delta
        if positionElapsed >= 0.2 then
            positionElapsed = 0
            UpdatePosition()
        end
        if refreshElapsed >= 30 then
            refreshElapsed = 0
            PFK.RequestKeystones()
            PFK.UpdateKeyList()
        end
    end)
    keyListFrame:SetScript("OnHide", function() titleEditBox:ClearFocus() end)
    local function UpdateVisibility()
        local entry = LFGListFrame.EntryCreation
        local search = LFGListFrame.SearchPanel
        local category = entry:IsShown() and entry.selectedCategory
            or (search and search:IsShown() and search.categoryID)
        keyListFrame:SetShown(category == 2)
        if keyListFrame:IsShown() then
            UpdatePosition()
            PFK.RequestKeystones()
            PFK.UpdateKeyList()
        end
    end
    hooksecurefunc("LFGListFrame_SetActivePanel", UpdateVisibility)
    LFGListFrame:HookScript("OnShow", UpdateVisibility)
    UpdateVisibility()
end
