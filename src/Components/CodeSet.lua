local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local components = plugin.Components
local uiUtils = components.UIUtils

local Label = require(components.Label)
local CodeBlock = require(components.CodeBlock)
local Padding = require(uiUtils.Padding)
local TextHugged = require(uiUtils.TextHugged)
local Container = require(uiUtils.Container)

local New = Fusion.New
local Hydrate = Fusion.Hydrate
local Children = Fusion.Children
local Value = Fusion.Value
local Computed = Fusion.Computed
local OnEvent = Fusion.OnEvent
local Tween = Fusion.Tween

type CodeSetProps = {
    HeaderText : string,
    CodeBlockText : string,
    [any]: any
}

type ButtonProps = {
    ImageProps : {
        [any]: any
    },
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "HeaderText",
    "CodeBlockText",
    "ImageProps"
}

local IMAGE_ID = "https://www.roblox.com/asset/?id=%s"

local function Button(props : ButtonProps)
    local isHovering = Value(false)
    local hydrateProps = table.clone(props)

    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "TextButton" {
        Size = UDim2.fromOffset(30, 30),
        BackgroundColor3 = Tween(Computed(function()
            if isHovering:get() == false then
                return Color3.fromRGB(72, 72, 72)
            end
            return Color3.fromRGB(60, 60, 60)
        end), TweenInfo.new(0.25)),
        [Children] = {
            New "UICorner" {
                CornerRadius = UDim.new(0, 5)
            },
            Hydrate(New "ImageLabel" {
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
            })(props.ImageProps)
        },
        [OnEvent "MouseEnter"] = function()
            isHovering:set(true)
        end,
        [OnEvent "MouseLeave"] = function()
            isHovering:set(false)
        end
    })(hydrateProps)
end

local function CodeSet(props : CodeSetProps)
    local hasCollapsed = Value(false)

    local hydrateProps = table.clone(props)

    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(Container {
        BackgroundColor3 = Color3.fromRGB(44, 44, 44),
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        UIListLayoutProps = {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, 15)
        },
        [Children] = {
            New "UICorner" {
                CornerRadius = UDim.new(0, 8)
            },
            Container {
                BackgroundTransparency = 1,
                UIListLayoutProps = {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 7)
                },
                [Children] = {
                    Label {
                        Text = props.HeaderText or "Code",
                        Size = UDim2.fromScale(1, 0),
                        TextSize = 30,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        [TextHugged] = Value("Y"),
                    },
                    Container {
                        BackgroundTransparency = 1,
                        UIListLayoutProps = {
                            FillDirection = Enum.FillDirection.Horizontal,
                            Padding = UDim.new(0, 10),
                        },
                        [Children] = {
                            Button {
                                Name = "Expand",
                                ImageProps = {
                                    Image = string.format(IMAGE_ID, "11879418426"),
                                    Size = UDim2.fromOffset(15, 15),
                                },
                                [OnEvent "Activated"] = function()
                                    warn("[CodeSet] WIP FUNCTION. MEANT TO EXPAND THIS TO ANOTHER WINDOW.")
                                end
                            },
                            Button {
                                Name = "Collapse",
                                ImageProps = {
                                    Size = UDim2.fromOffset(20, 20),
                                    Image = Computed(function()
                                        if hasCollapsed:get() then
                                            return string.format(IMAGE_ID, "11930110850")
                                        end
                                        return string.format(IMAGE_ID, "11930108893")
                                    end)
                                },
                                [OnEvent "Activated"] = function()
                                    hasCollapsed:set(not hasCollapsed:get())
                                end
                            }
                        }
                    },
                    Padding {
                        PaddingLeft = 10,
                        PaddingAll = 5,
                    },
                }
            },
            New "Frame" {
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Color3.fromRGB(206, 189, 189)
            },
            New "Frame" {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.fromScale(1, 0),
                BackgroundTransparency = 1,
                Visible = Computed(function()
                    return not hasCollapsed:get()
                end),
                [Children] = {
                    CodeBlock {
                        Text = props.CodeBlockText,
                    },
                    Padding {
                        PaddingLeft = 15,
                        PaddingBottom = 10
                    }
                }
            }
        }
    })(hydrateProps)
end

return CodeSet