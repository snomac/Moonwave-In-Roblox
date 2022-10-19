local TextService = game:GetService("TextService")
local TextScaled = {}

TextScaled.type = "SpecialKey"
TextScaled.kind = "TextScaled"
TextScaled.stage = "self"

local function recalculateTextSize(value, instance)
    if value.kind == "Value" and value:get() == false then
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

    instance.Size = UDim2.fromOffset(
        newSize.X,
        newSize.Y
    )
end

function TextScaled:apply(value, applyTo, cleanupTasks)
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

return TextScaled