local plugin = script.Parent.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate

type ContainerProps = {
    UIListLayoutProps : {
        [any]: any
    },
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "UIListLayoutProps"
}

local function Container(props : ContainerProps)
    local hydrateProps = table.clone(props)

    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "Frame" {
        AutomaticSize = Enum.AutomaticSize.XY,
        [Children] = Hydrate(New "UIListLayout" {
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder
        })(props.UIListLayoutProps or {})
    })(hydrateProps)
end

return Container