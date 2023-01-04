local TextService = game:GetService("TextService")
local TextHugged = {}

TextHugged.type = "SpecialKey"
TextHugged.kind = "TextHugged"
TextHugged.stage = "self"

local function recalculateTextSize(value, instance)
    if value.kind ~= "Value" then
        warn("[TextHugged] Kind is not a Value type.")
        return
    end

    local text = instance.Text

    local newSize = TextService:GetTextSize(
        text,
        instance.TextSize,
        instance.Font,
        Vector2.new(
            math.huge,
            math.huge
        )
    )

    instance.Size = UDim2.new(
        instance.Size.X.Scale,
        if string.find(value:get(), "X") then newSize.X else instance.AbsoluteSize.X,
        instance.Size.Y.Scale,
        if string.find(value:get(), "Y") then newSize.Y else instance.AbsoluteSize.Y
    )
end

function TextHugged:apply(value, applyTo, cleanupTasks)
    local instance = applyTo.instance

    local sizeChangeConnection = instance:GetPropertyChangedSignal("TextSize"):Connect(function()
        recalculateTextSize(value, instance)
    end)

    local textChangeConnection = instance:GetPropertyChangedSignal("Text"):Connect(function()
        recalculateTextSize(value, instance)
    end)

    recalculateTextSize(value, instance)

    table.insert(cleanupTasks, sizeChangeConnection)
    table.insert(cleanupTasks, textChangeConnection)
end

return TextHugged