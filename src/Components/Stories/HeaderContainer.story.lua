local plugin = script.Parent.Parent.Parent

local Fusion = require(plugin.Packages.Fusion)
local Children = Fusion.Children
local Value = Fusion.Value

local HeaderContainer = require(plugin.Components.HeaderContainer)
local Label = require(plugin.Components.Label)

local TextHugged = require(plugin.Components.UIUtils.TextHugged)

local sizes = {40, 33, 28}

-- TODO: add a separate Header component, this is for testing right now.
local function Header()
    return Label {
        TextSize = sizes[math.random(1, 3)],
        Text = "Header",
        [TextHugged] = Value("XY")
    }
end

return function(target)
    local header = HeaderContainer {
        Parent = target,
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