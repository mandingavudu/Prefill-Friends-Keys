local addonName, PFK = ...

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, _, name)
    if name ~= addonName then
        return
    end
    self:UnregisterEvent("ADDON_LOADED")
    if type(_G.PrefillFriendsKeysDB) ~= "table" then
        _G.PrefillFriendsKeysDB = {}
    end

    local settings = _G.PrefillFriendsKeysDB
    settings.playstyle = PFK.GetDefaultPlaystyle()
    local styles = Enum.LFGEntryGeneralPlaystyle

    local category = Settings.RegisterVerticalLayoutCategory("Prefill Friends Keys")
    local playstyleSetting = Settings.RegisterAddOnSetting(
        category,
        addonName .. "_DEFAULT_PLAYSTYLE",
        "playstyle",
        settings,
        Settings.VarType.Number,
        PFK.L.OPTIONS_PLAYSTYLE,
        PFK.DEFAULT_PLAYSTYLE
    )
    local function GetOptions()
        local container = Settings.CreateControlTextContainer()
        for _, playstyle in ipairs({ styles.Learning, styles.FunRelaxed, styles.FunSerious, styles.Expert }) do
            container:Add(playstyle, PFK.PlaystyleLabels[playstyle])
        end
        return container:GetData()
    end
    Settings.CreateDropdown(category, playstyleSetting, GetOptions,
        PFK.L.OPTIONS_PLAYSTYLE_TOOLTIP)
    Settings.RegisterAddOnCategory(category)
end)
