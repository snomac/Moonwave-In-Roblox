local TextService = game:GetService("TextService")

local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Hydrate = Fusion.Hydrate
local Ref = Fusion.Ref

type LabelProps = {
    [any]: any
}

local function Label(props : LabelProps)

    return Hydrate(New "TextLabel" {
        Size = UDim2.new(0, 15, 0, 50),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })(props)
end

return Label