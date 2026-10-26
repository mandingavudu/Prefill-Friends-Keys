local _, PFK = ...

PFK.KEY_EXPIRATION_SECONDS = 600
PFK.DEFAULT_PLAYSTYLE = Enum.LFGEntryGeneralPlaystyle.FunSerious -- Competitive

local styles = Enum.LFGEntryGeneralPlaystyle
PFK.PlaystyleLabels = {
    [styles.Learning] = GROUP_FINDER_GENERAL_PLAYSTYLE1,
    [styles.FunRelaxed] = GROUP_FINDER_GENERAL_PLAYSTYLE2,
    [styles.FunSerious] = GROUP_FINDER_GENERAL_PLAYSTYLE3,
    [styles.Expert] = GROUP_FINDER_GENERAL_PLAYSTYLE4,
}

function PFK.GetDefaultPlaystyle()
    local settings = _G.PrefillFriendsKeysDB
    local playstyle = type(settings) == "table" and settings.playstyle

    if PFK.PlaystyleLabels[playstyle] then
        return playstyle
    end

    return PFK.DEFAULT_PLAYSTYLE
end

function PFK.FindMythicPlusActivity(challengeMapID)
    local name, _, _, _, _, instanceMapID = C_ChallengeMode.GetMapUIInfo(challengeMapID)
    if not name then
        return
    end
    for _, activityID in ipairs(C_LFGList.GetAvailableActivities(2, nil, 0) or {}) do
        local info = C_LFGList.GetActivityInfoTable(activityID)
        if info and info.isMythicPlusActivity and info.categoryID == 2 then
            local matches
            if instanceMapID and instanceMapID > 0 and info.mapID and info.mapID > 0 then
                matches = info.mapID == instanceMapID
            else
                matches = C_LFGList.GetActivityGroupInfo(info.groupFinderActivityGroupID) == name
            end
            if matches then
                return activityID, info
            end
        end
    end
end
