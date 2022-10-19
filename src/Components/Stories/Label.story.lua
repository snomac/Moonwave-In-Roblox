local plugin = script:FindFirstAncestor("Plugin")

local Label = require(plugin.Components.Label)
local TextScaled = require(plugin.Components.UIUtils.TextScaled)

local Fusion = require(plugin.Packages.Fusion)
local Computed = Fusion.Computed
local Value = Fusion.Value

return function(target)
    local label = Label {
        Parent = target,
        Size = UDim2.new(0, 50, 0, 25),
        Position = UDim2.fromScale(0.15, 0.15),
        Text = "Hello, world!",
        TextSize = Computed(function()
            local newSize = math.random(30, 50)
            return newSize
        end),
        TextWrapped = true,
        [TextScaled] = Value(true),
    }

    return function()
        label:Destroy()
    end
end