local TextService = game:GetService("TextService")

local plugin = script:FindFirstAncestor("Plugin")
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Hydrate = Fusion.Hydrate
local Ref = Fusion.Ref

type LabelProps = {
    [any]: any
}

local function Label(props : LabelProps)
    local headerLabelRef = Value()

    return Hydrate(New "TextLabel" {
        Size = UDim2.new(0, 15, 0, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Font = props.Font or Enum.Font.SourceSansBold,
        [Ref] = headerLabelRef
    })(props)
end

return Label