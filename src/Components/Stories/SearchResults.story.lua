local plugin = script.Parent.Parent.Parent
local components = plugin.Components

local SearchResult = require(components.SearchResult)
local SearchResultsList = require(components.SearchResultsList)
local TextHugged = require(components.UIUtils.TextHugged)

local Fusion = require(plugin.Packages.Fusion)
local Computed = Fusion.Computed
local Value = Fusion.Value

return function(target)
    local articles = {
        SearchResult {
            TitleName = "Hello",
            SourceInstance = workspace:GetFullName(),
            Description = "This is a welcome page. **Welcome!**"
        },
        SearchResult {
            TitleName = "Goodbye",
            SourceInstance = workspace:GetFullName(),
            Description = "We're sorry. This program is going to get away."
        }
    }

    local list = SearchResultsList {
        Articles = Value(articles),
        SearchPrompt = Value("He"),
        Parent = target
    }

    return function()
        list:Destroy()
    end
end