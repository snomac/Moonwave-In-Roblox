local plugin = script:FindFirstAncestor("Plugin")
local Fusion = require(plugin.Packages.Fusion)

local Value = Fusion.Value

local globalStates = {
    articles = Value({})
}

return globalStates