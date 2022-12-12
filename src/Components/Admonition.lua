local plugin = script.Parent.Parent
local components = plugin.Components
local uiUtils = components.UIUtils

local Fusion = require(plugin.Packages.Fusion)

local Label = require(components.Label)
local TextIcon = require(components.TextIcon)
local TextHugged = require(uiUtils.TextHugged)
local Padding = require(uiUtils.Padding)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate

type AdmonitionProps = {
    AdmonitionType : "Note" | "Tip" | "Info" | "Caution" | "Danger",
    HeaderText : string?,
}

type AdmonitionInfo = {
    color : Color3,
    iconText : string
}

local admonitionSettings : {[string] : AdmonitionInfo} = {
    Note = {
        color = Color3.fromRGB(103, 103, 103),
        iconText = "<i>i</i>"
    },
    Tip = {
        color = Color3.fromRGB(206, 189, 189),
        iconText = "<b><i>i</i></b>"
    },
    Info = {
        color = Color3.fromRGB(101, 109, 153),
        iconText = "<b>!</b>"
    },
    Caution = {
        color = Color3.fromRGB(205, 190, 49),
        iconText = "<b>!!</b>"
    },
    Danger = {
        color = Color3.fromRGB(186, 29, 29),
        iconText = "<b>!!!</b>"
    },
}

local COMPONENT_ONLY_PROPERTIES = {
    "AdmonitionType",
    "HeaderText",
    Children
}

local function Admonition(props : AdmonitionProps)
    local admonitionSetting = admonitionSettings[props.AdmonitionType]
    local admonitionColor = admonitionSetting.color

    local hydrateProps = table.clone(props)
    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "Frame" {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = Color3.fromRGB(44, 44, 44),
        [Children] = {
            New "UIListLayout" {
                Padding = UDim.new(0, 5),
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            New "UICorner" {
                CornerRadius = UDim.new(0, 8)
            },
            New "Frame" {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                LayoutOrder = -5,
                [Children] = {
                    New "UIListLayout" {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 10)
                    },
                    TextIcon {
                        BackgroundColor3 = admonitionColor,
                        TextColor3 = Color3.fromRGB(44, 44, 44),
                        Text = admonitionSetting.iconText,
                        RichText = true,
                        TextSize = 20,
                    },
                    Label {
                        Text = props.HeaderText or props.AdmonitionType,
                        TextColor3 = admonitionColor,
                        Font = Enum.Font.SourceSansBold,
                        TextSize = 30,
                        [TextHugged] = Value("XY")
                    },
                    Padding {
                        PaddingTop = 10,
                        PaddingLeft = 13,
                        PaddingBottom = 5,
                    }
                }
            },
            New "Frame" {
                Size = UDim2.new(1, 0, 0, 1),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = admonitionColor,
                LayoutOrder = -4
            },
            New "Frame" {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                LayoutOrder = -3,
                [Children] = {
                    Padding {
                        PaddingLeft = 13,
                        PaddingBottom = 5
                    },
                    New "UIListLayout" {},
                    props[Children]
                }
            }
        }
    })(hydrateProps)
end

return Admonition