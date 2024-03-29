Sapped = Sapped or {}

local frame = CreateFrame("Frame")

-- Conditions for enabling the addon
local function shouldEnableAddon()
    local _, instanceType = GetInstanceInfo()
    local isPvpInstance = instanceType == "pvp" or instanceType == "arena"
    return isPvpInstance
end

-- Update event registration based on conditions
local function updateEventRegistration()
    if shouldEnableAddon() then
        frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    else
        frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end

-- Message to send when the player is sapped
local function SendMessage()
    SendChatMessage(Sapped.GetMessage(), "SAY")
end

frame:SetScript("OnEvent", function(_, event, ...)
    -- Check if the event is a combat log event
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        -- Get the combat log event info
        local _, eventType, _, _, _, _, _, destGUID, _, _, _, spellId = CombatLogGetCurrentEventInfo()
        -- Check if the event is a debuff and the player is the target
        if (eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_REFRESH") and destGUID == UnitGUID("player") then
            -- Check if the spell ID matches the "Sapped" debuff across different expansions
                if spellId == 6770 -- Retail version of "Sapped"
                or spellId == 2070 -- Classic version of "Sapped"
                or spellId == 11297 -- Another Classic version
                or spellId == 51724 then -- Wrath of the Lich King version of "Sapped", for example
                SendMessage()
            end
        end
    elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_FLAGS_CHANGED" then
        updateEventRegistration()
    end
end)

-- Register events to handle zone changes and PvP flag changes
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("PLAYER_FLAGS_CHANGED")

-- Initial check in case the addon is loaded while already in a relevant zone
updateEventRegistration()

SLASH_SAPPED1 = "/sapped"
SlashCmdList["SAPPED"] = function()
    SendMessage()
end