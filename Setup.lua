Sapped = Sapped or {
    State = {
        DefaultMessage = "Sapped!! {rt8} {rt8}",
        CustomMessage = "",
    }
}

function Sapped.GetMessage()
    return Sapped.State.CustomMessage ~= "" and Sapped.State.CustomMessage or Sapped.State.DefaultMessage
end

-- Handling the necessary events to save/load data
local function HandleSavedVariables(_, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "Sapped" then
        -- Load saved variables into the addon's state
        Sapped.State = SappedDB or Sapped.State
    elseif event == "PLAYER_LEAVING_WORLD" then
        -- Ensure SappedDB is updated with the latest State before logging out or UI reload
        SappedDB = Sapped.State
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
eventFrame:SetScript("OnEvent", HandleSavedVariables)
