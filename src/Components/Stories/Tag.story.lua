local plugin = script.Parent.Parent

local Fusion = require(plugin.Packages.Fusion)
local Children = Fusion.Children

local Tag = require(plugin.Components.Tag)

return function(target)
    local header = Tag {
        Size = UDim2.fromOffset(108, 35),
        Parent = target,
        TagTextContent = "enum"
    }

    return function()
        header:Destroy()
    end
end