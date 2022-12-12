local TextService = game:GetService("TextService")

local plugin = script:FindFirstAncestor("Plugin")
local components = plugin.Components

local globalStates = require(plugin.Utils.globalStates)
local Fusion = require(plugin.Packages.Fusion)

local SearchBar = require(components.SearchBar)
local SearchResultsList = require(components.SearchResultsList)
local SearchResult = require(components.SearchResult)

local New = Fusion.New
local Value = Fusion.Value
local Hydrate = Fusion.Hydrate
local Children = Fusion.Children
local Observer = Fusion.Observer
local ForValues = Fusion.ForValues
local Computed = Fusion.Computed
local Tween = Fusion.Tween

type SearchProps = {
    [any]: any
}

local function Search(props : SearchProps)
    local articles = globalStates.articles

    local searchPrompt = Value("")
    local convertedArticles = ForValues(articles, function(article)
        return SearchResult {
            TitleName = article.title,
            Description = article.description,
            SourceInstance = article.scriptOrigin
        }
    end)

    local resultListSize = Tween(
        Computed(function()
            if searchPrompt:get() == "" then
                return UDim2.new(1, 0, 0, 0)
            end
            return UDim2.new(1, 0, 0, 250)
        end),
        TweenInfo.new(0.5)
    )

    return Hydrate(New "Frame" {
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        [Children] = {
            New "UIListLayout" {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 20)
            },
            SearchBar {
                -- AutomaticSize = Enum.AutomaticSize.XY,
                Size = UDim2.new(1, 0, 0, 35),
                OnSearchTextChanged = function(text)
                    searchPrompt:set(text)
                end
            },
            SearchResultsList {
                SearchPrompt = searchPrompt,
                Articles = convertedArticles,
                Visible = Computed(function()
                    if searchPrompt:get() == "" and resultListSize:get() == UDim2.new(1) then
                        return false
                    end
                    return true
                end),
                Size = resultListSize
            }
        }
    })(props)
end

return Search