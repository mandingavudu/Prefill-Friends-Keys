local _, PFK = ...

local locales = {
    enUS = {
        OPTIONS_PLAYSTYLE = "Default playstyle",
        OPTIONS_PLAYSTYLE_TOOLTIP = "Playstyle applied when you select a keystone. You can still change it in the group listing.",
        SELECT_OUTSIDE_COMBAT = "Select a key outside combat.",
        OPEN_GROUP_CREATION = "Open Start a Group in Dungeons first.",
        KEY_EXPIRED = "This key expired. Click Refresh.",
        ACTIVITY_UNAVAILABLE = "No available Mythic+ activity matches this key.",
        KEY_SELECTED = "Dungeon / Mythic+ selected. Verify the title; copy this level if needed.",
        PREPARE_LISTING = "Click to prepare a dungeon listing.",
        UNKNOWN_DUNGEON = "Unknown dungeon",
        AVAILABLE_KEYS = "Available keys",
        REFRESH = "Refresh",
        REFRESH_OUTSIDE_COMBAT = "Refresh outside combat.",
        REQUESTING_KEYS = "Requesting keys. Refresh is limited to once per 10 seconds.",
        NO_SHARED_KEYS = "No shared keys yet.\nFriends need this addon; party and guild keys can also come from LibKeystone addons.",
        TITLE_LEVEL = "Title level (Ctrl+C, then paste into Title)",
        SELECT_KEY_HINT = "Open Start a Group, then select a key.\nBlizzard controls automatic title text.",
        KEY_RECEIVED = "%s - received %ds ago",
        SOURCE_SELF = "You",
        SOURCE_PARTY = "Party",
        SOURCE_GUILD = "Guild",
        SOURCE_BATTLENET = "Battle.net",
        SOURCE_FRIEND = "Friend",
    },
}

locales.enGB = locales.enUS

PFK.L = locales[GetLocale()] or locales.enUS
