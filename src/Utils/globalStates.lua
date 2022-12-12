local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local Value = Fusion.Value

local globalStates = {
    articles = Value({})
}

return globalStates