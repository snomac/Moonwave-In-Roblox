local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)
local components = plugin.Components

local SearchBox = require(components.SearchBox)
local TextIcon = require(components.TextIcon)
local Padding = require(components.UIUtils.Padding)

local New = Fusion.New
local Value = Fusion.Value
local OnEvent = Fusion.OnEvent
local OnChange = Fusion.OnChange
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate
local Tween = Fusion.Tween

type SearchBarProps = {
    OnHelpButtonActivated : (() -> nil)?,
    OnSearchTextChanged : ((string) -> nil)?,
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "OnHelpButtonActivated",
    "OnSearchTextChanged"
}

local function SearchBar(props : SearchBarProps)
    local iconColor = Value(Color3.fromRGB(44, 44, 44))

    local hydrateProps = table.clone(props)
    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "Frame" {
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(27, 27, 27),
        [Children] = {
            New "UIListLayout" {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 8),
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center
            },
            SearchBox {
                LayoutOrder = 1,
                Size = UDim2.new(1, -35, 0, 25),
                AutomaticSize = Enum.AutomaticSize.Y,
                [OnChange "Text"] = props.OnSearchTextChanged
            },
            TextIcon {
                Text = "<i>i</i>",
                RichText = true,
                Font = Enum.Font.Merriweather,
                LayoutOrder = 2,
                BackgroundColor3 = Tween(iconColor, TweenInfo.new(0.25)),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                [OnEvent "Activated"] = function()
                    if props.OnHelpButtonActivated then
                        props.OnHelpButtonActivated()
                    end
                end,
                [OnEvent "MouseEnter"] = function()
                    iconColor:set(Color3.fromRGB(56, 56, 56))
                end,
                [OnEvent "MouseLeave"] = function()
                    iconColor:set(Color3.fromRGB(44, 44, 44))
                end
            },
            New "UICorner" {
                CornerRadius = UDim.new(0, 8)
            },
            Padding {
                PaddingLeft = 5,
                PaddingRight = 5
            }
        }
    })(hydrateProps)
end

return SearchBar