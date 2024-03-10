SappedAddon = SappedAddon or {}

-- SaappedDB = {
--     AddonName = "Sapped",
--     DefaultMessage = "Sapped!! {rt8} {rt8}asd",
--     CustomMessage = "asd",
-- }

AddonName = "Sapped"
DefaultMessage = "Sapped!! {rt8} {rt8}asd"
CustomMessage = ""

function SappedAddon.GetMessage()
    -- Use custom message if present, otherwise use default message
    -- return SappedDB.CustomMessage ~= "" and SappedDB.CustomMessage or SappedDB.DefaultMessage
    -- return "Sapped!! {rt8} {rt8}wd"
    return CustomMessage ~= "" and CustomMessage or DefaultMessage
end
