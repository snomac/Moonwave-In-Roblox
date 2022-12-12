local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)
local components = plugin.Components
local utils = plugin.Utils

local Padding = require(components.UIUtils.Padding)
local TextHugged = require(components.UIUtils.TextHugged)
local Label = require(components.Label)
local StringUtil = require(utils.StringUtil)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate
local Computed = Fusion.Computed

type Article = {
    title : TextLabel,
    scriptOrigin : TextLabel,
    rawContent : TextLabel
}

type SearchResultsListProps = {
    -- should be a Value in order for this to work
    SearchPrompt : any,
    -- TEMPORARY VALUE, IS A STATE
    Articles : {get: (SearchResultsListProps) -> {[number]: Article}},
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "SearchPrompt",
    "Articles"
}

local function SearchResultsList(props : SearchResultsListProps)
    local hydrateProps = table.clone(props)
    for index, childInstanceName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[childInstanceName] = nil
    end

    return Hydrate(New "Frame" {
        Size = UDim2.new(1, 0, 0, 250),
        BackgroundColor3 = Color3.fromRGB(44, 44, 44),
        [Children] = {
            New "UICorner" {
                CornerRadius = UDim.new(0, 8)
            },
            New "UIStroke" {
                Thickness = 3,
                Color = Color3.fromRGB(27, 27, 27)
            },
            New "ScrollingFrame" {
                BackgroundColor3 = Color3.fromRGB(44, 44, 44),
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ClipsDescendants = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromScale(1, 0),
                ScrollBarThickness = 0,
                [Children] = {
                    New "UIListLayout" {
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 15)
                    },
                    Padding {
                        PaddingAll = 15,
                        PaddingRight = 10,
                        PaddingLeft = 10
                    },
                    Label {
                        Font = Enum.Font.SourceSans,
                        Text = Computed(function()
                            return string.format("Results for <b>\"%s\"</b>", props.SearchPrompt:get())
                        end),
                        TextSize = 20,
                        RichText = true,
                        TextColor3 = Color3.fromRGB(154, 154, 154),
                        Size = UDim2.new(1, 0, 0, 35),
                        LayoutOrder = -1
                    },
                    Computed(function()
                        if props.SearchPrompt:get() == "" then
                            return {}
                        end

                        local matches = {
                            title = {},
                            rawContent = {},
                            scriptOrigin = {}
                        }
                        local sortOrder = {"title", "rawContent", "scriptOrigin"}

                        for index, instance in props.Articles:get() do
                            local hasFound = false
                            for index, childInstance in sortOrder do
                                local location = (string.find(
                                    string.lower(instance[childInstance].Text),
                                    string.lower(props.SearchPrompt:get()),
                                    1,
                                    true
                                ))
                                if location and (not hasFound) then
                                    table.insert(matches[childInstance], instance)
                                    hasFound = true
                                end
                            end
                        end

                        return {
                            unpack(matches.title),
                            unpack(matches.rawContent),
                            unpack(matches.scriptOrigin)
                        }
                    end)
                }
            }
        }
})(hydrateProps)
end

return SearchResultsList