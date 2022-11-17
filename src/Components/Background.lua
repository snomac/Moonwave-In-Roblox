local plugin = script:FindFirstAncestor("Plugin")
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Hydrate = Fusion.Hydrate

type BackgroundProps = {
    [any]: any
}

local function Background(props)
    return Hydrate(New "Frame" {

    })(props)
end

return Background