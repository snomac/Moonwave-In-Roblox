local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)
local components = plugin.Components

local Padding = require(components.UIUtils.Padding)
local TextHugged = require(components.UIUtils.TextHugged) 
local Label = require(components.Label)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate
local Computed = Fusion.Computed
local OnEvent = Fusion.OnEvent
local Tween = Fusion.Tween

type SearchResultProps = {
    TitleName : string,
    SourceInstance : Instance | string,
    Description : string,
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "TitleName",
    "SourceInstance",
    "Description",
    "TextHugged"
}

type ResultLabelProps = {
    TextHugged : "X" | "Y" | "XY",
    [any]: any
}

local function ResultLabel(props : ResultLabelProps)
    local hydrateProps = table.clone(props)
    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(Label {
        TextSize = 20,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.new(255, 255, 255),
        Size = UDim2.fromOffset(0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
        [TextHugged] = Value(props.TextHugged or "XY"),
    })(hydrateProps)
end

local function onMouseInteraction(value)
    value:set(not value:get())
end

local function SearchResult(props : SearchResultProps)
    local hovered = Value(false)

    local hydrateProps = table.clone(props)
    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "Frame" {
        BackgroundColor3 = Color3.fromRGB(27, 27, 27),
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        [OnEvent "MouseEnter"] = function()
            onMouseInteraction(hovered)
        end,
        [OnEvent "MouseLeave"] = function()
            onMouseInteraction(hovered)
        end,
        [Children] = {
            New "UIListLayout" {
                Padding = UDim.new(0, 3),
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            Padding {
                PaddingAll = 10,
                PaddingLeft = 5
            },
            ResultLabel {
                Name = "title",
                Text = props.TitleName,
                TextSize = 30,
                LayoutOrder = 1
            },
            ResultLabel {
                Name = "scriptOrigin",
                Text = Computed(function()
                    local sourceInstance = props.SourceInstance
                    local name = sourceInstance
                    if typeof(sourceInstance) == "Instance" then
                        name = sourceInstance:GetFullName()
                    end
                    return name
                end),
                Font = Enum.Font.SourceSansItalic,
                LayoutOrder = 2
            },
            ResultLabel {
                Name = "rawContent",
                Text = props.Description,
                TextColor3 = Color3.fromRGB(154, 154, 154),
                Font = Enum.Font.SourceSans,
                LayoutOrder = 3,
                -- TextTruncate.AtEnd not showing: workaround
                RichText = false,
                Size = UDim2.new(1, 0, 0, 20)
            },
            New "UICorner" {
                CornerRadius = UDim.new(0, 8)
            },
            New "UIStroke" {
                Color = Color3.fromRGB(180, 165, 165),
                Thickness = Tween(Computed(function()
                    if hovered:get() then
                        return 1
                    end
                    return 0
                end), TweenInfo.new(0.15))
            }
        }
    })(hydrateProps)
end

return SearchResult