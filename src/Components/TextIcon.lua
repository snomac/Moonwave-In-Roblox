local plugin = script:FindFirstAncestor("Plugin")
local Fusion = require(plugin.Packages.Fusion)
local Padding = require(plugin.Components.UIUtils.Padding)

local New = Fusion.New
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate
local OnEvent = Fusion.OnEvent

type TextIconProps = {
    Text : string,
    Font : Enum.Font?,
    RichText : boolean?,
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "Text",
    "Font",
    "RichText",
}

local function TextIcon(props : TextIconProps)
    local hydrateProps = table.clone(props)
    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "TextButton" {
        Size = UDim2.fromOffset(25, 25),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        RichText = props.RichText or false,
        Font = props.Font or Enum.Font.SourceSans,
        Text = props.Text,
        [Children] = {
            Padding {
                PaddingAll = 1.5
            },
            New "UICorner" {
                CornerRadius = UDim.new(0, 5)
            }
        }
    })(hydrateProps)
end

return TextIcon