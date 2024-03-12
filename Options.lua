Sapped = Sapped or {}

-- Utility function to create buttons
local function CreateButton(name, parent, label, point, relativeFrame, relativePoint, offsetX, offsetY, width, height)
    local button = CreateFrame("Button", name, parent, "UIPanelButtonTemplate")
    button:SetPoint(point, relativeFrame, relativePoint, offsetX, offsetY)
    button:SetSize(width, height)
    button:SetText(label)
    return button
end

-- Setup function for the main panel
local function SetupMainPanel()
    --- @class SappedPanel : Frame
    local panel = CreateFrame("Frame")
    panel.name = "Sapped"

    -- Panel title
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Settings")

    -- Edit box for custom message
    local editBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    editBox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
    editBox:SetSize(200, 20)
    editBox:SetAutoFocus(false)
    
    -- OnShow: Update editBox text to current message
    panel:SetScript("OnShow", function()
        editBox:SetText(Sapped.GetMessage())
    end)

    return panel, editBox
end

-- Function to add buttons to the main panel
local function AddButtonsToPanel(panel, editBox)
    -- Save button setup
    local saveButton = CreateButton("SaveButton", panel, "Save", "LEFT", editBox, "RIGHT", 10, 0, 80, 22)
    saveButton:SetScript("OnClick", function()
        Sapped.State.CustomMessage = editBox:GetText()
    end)

    -- Reset button setup
    local resetButton = CreateButton("ResetButton", panel, "Reset", "LEFT", saveButton, "RIGHT", 10, 0, 80, 22)
    resetButton:SetScript("OnClick", function()
        editBox:SetText(Sapped.State.DefaultMessage)
        Sapped.State.CustomMessage = ""
    end)
end

-- Main execution
local panel, editBox = SetupMainPanel()
AddButtonsToPanel(panel, editBox)
InterfaceOptions_AddCategory(panel)