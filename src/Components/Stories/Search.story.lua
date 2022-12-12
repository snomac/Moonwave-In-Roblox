local plugin = script:FindFirstAncestor("Plugin")

local Search = require(plugin.Components.Search)
local globalStates = require(plugin.Utils.globalStates)

local Fusion = require(plugin.Packages.Fusion)
local Computed = Fusion.Computed
local Value = Fusion.Value

local articles = globalStates.articles

return function(target)
    articles:set({
        {
            title = "Hello",
            scriptOrigin = workspace:GetFullName(),
            description = "This is a welcome page. **Welcome!**"
        },
        {
            title = "test Title",
            scriptOrigin = workspace:GetFullName(),
            description = "Hello"
        },
        {
            title = "Goodbye",
            scriptOrigin = "Hello",
            description = "We're sorry. This program is going to get away."
        },
        {
            title = "It somewhat works Lol!",
            scriptOrigin = workspace:GetFullName(),
            description = "We're sorry. This program is going to get away."
        }
    })

    local search = Search {
        Parent = target
    }
    return function()
        articles:set({})
        search:Destroy()
    end
end