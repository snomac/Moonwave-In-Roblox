local plugin = script.Parent.Parent.Parent

local CodeBlock = require(plugin.Components.CodeBlock)
local TextHugged = require(plugin.Components.UIUtils.TextHugged)

local Fusion = require(plugin.Packages.Fusion)
local Computed = Fusion.Computed
local Value = Fusion.Value

return function(target)
    local label = CodeBlock {
        Parent = target,
        Text = "print('Hello!') -- prints hello",
        BackgroundTransparency = 0
    }
    return function()
        label:Destroy()
    end
end