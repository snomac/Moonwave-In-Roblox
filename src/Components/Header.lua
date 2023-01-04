local plugin = script.Parent.Parent
local components = plugin.Components
local UiUtils = components.UIUtils

local Fusion = require(plugin.Packages.Fusion)
local Container = require(UiUtils.Container)
local TextHugged = require(UiUtils.TextHugged)
local Label = require(components.Label)

local Hydrate = Fusion.Hydrate
local Children = Fusion.Children
local Value = Fusion.Value

type HeaderProps = {
    TextLabelProps : {
        [any]: any
    },
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "TextLabelProps"
}

local function Header(props : HeaderProps)
    local hydrateProps = table.clone(props)

    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(Container {
        BackgroundTransparency = 1,
        [Children] = {
            Hydrate(Label {
                Size = UDim2.fromScale(1, 0),
                TextSize = 40,
                Font = Enum.Font.SourceSansBold,
                LayoutOrder = 1,
                [TextHugged] = Value("Y")
            })(props.TextLabelProps or {})
        }
    })(hydrateProps)
end

return Header