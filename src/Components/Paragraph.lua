local TextService = game:GetService("TextService")
local plugin = script:FindFirstAncestor("Plugin")
local uiUtils = plugin.Components.UIUtils
local getValidUiAnchor = require(uiUtils.getValidUiAnchor)
local scaleToOffset = require(uiUtils.scaleToOffset)

local Fusion = require(plugin.Packages.Fusion)
local Value = Fusion.Value
local Ref = Fusion.Ref
local Computed = Fusion.Computed
local Observer = Fusion.Observer
local Hydrate = Fusion.Hydrate
local OnChange = Fusion.OnChange

local Label = require(plugin.Components.Label)

local PARAGRAPH_SIZE = UDim2.fromScale(1, 1)

type ParagraphProps = {
    [any]: any
}

local function Paragraph(props : ParagraphProps)
    local labelRef = Value()
    local isParented = Value(false)
    local anchorSize = Value(Vector2.new())
    local anchor = Value()
    local anchorObserver = Observer(anchor)

    local newSize = Computed(function()
        local label : TextLabel = labelRef:get()

        if label == nil then
            return PARAGRAPH_SIZE
        end
        if isParented:get() == false then
            return PARAGRAPH_SIZE
        end

        local offsetLabel = scaleToOffset.fromRelativeAbsoluteSize(
            PARAGRAPH_SIZE,
            anchorSize:get()
        )

        local newSize = TextService:GetTextSize(
            label.Text,
            label.TextSize,
            label.Font,
            Vector2.new(
                offsetLabel.X.Offset,
                math.huge
            )
        )

        return UDim2.fromOffset(offsetLabel.X.Offset - 20, newSize.Y)
    end)

    local disconnect = anchorObserver:onChange(function()
        if anchor:get() ~= nil then
            anchor:get():GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                anchorSize:set(anchor:get().AbsoluteSize)
            end)
        end
    end)

    local label = Label {
        TextSize = 20,
        Size = newSize,
        TextWrapped = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSans,
        [OnChange "Parent"] = function()
            isParented:set(true)
            anchor:set(getValidUiAnchor(labelRef:get().Parent))
        end,
        [Ref] = labelRef
    }

    return Hydrate(label)(props)
end

return Paragraph