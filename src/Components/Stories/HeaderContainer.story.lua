local plugin = script:FindFirstAncestor("Plugin")

local Fusion = require(plugin.Packages.Fusion)
local Children = Fusion.Children
local Value = Fusion.Value

local HeaderContainer = require(plugin.Components.HeaderContainer)
local Label = require(plugin.Components.Label)

local TextScaled = require(plugin.Components.UIUtils.TextScaled)

local sizes = {40, 33, 28}

local function Header()
    return Label {
        -- just for testing's sake 😳
        TextSize = sizes[math.random(1, 3)],
        Text = "Header",
        [TextScaled] = Value(true)
    }
end

return function(target)
    local header = HeaderContainer {
        Parent = target,
        Position = UDim2.fromScale(0.15, 0.15),
        [Children] = {
            Header {},
            Header {},
            Header {},
        }
    }

    return function()
        header:Destroy()
    end
end