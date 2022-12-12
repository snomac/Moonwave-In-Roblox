local plugin = script.Parent.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Hydrate = Fusion.Hydrate

type PaddingProps = {
    PaddingAll : number?,
    PaddingBottom : number?,
    PaddingLeft : number?,
    PaddingRight : number?,
    PaddingTop : number?,
    [any] : any
}

local PADDING_PROPS = {
    "PaddingBottom",
    "PaddingLeft",
    "PaddingRight",
    "PaddingTop",
}
local COMPONENT_ONLY_PROPERTIES = {
    "PaddingAll"
}

local function Padding(props : PaddingProps)
    local hydrateProps = table.clone(props)
    for index, propertyName in PADDING_PROPS do
        hydrateProps[propertyName] = UDim.new(0, (props[propertyName] or 0) + (props.PaddingAll or 0))
    end

    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "UIPadding" {})(hydrateProps)
end

return Padding