local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate

type SearchBarProps = {
    [any]: any
}

local function SearchBox(props : SearchBarProps)
    return Hydrate(
        New "TextBox" {
            Size = UDim2.new(1, 0, 0, 25),
            Position = UDim2.fromScale(0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(44, 44, 44),
            BackgroundTransparency = 0,
            PlaceholderColor3 = Color3.fromRGB(103, 103, 103),
            PlaceholderText = "Search...",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            [Children] = New "UICorner" {
                CornerRadius = UDim.new(0, 5)
            }
        }
    )(props)
end

return SearchBox