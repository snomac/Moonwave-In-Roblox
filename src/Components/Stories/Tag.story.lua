local plugin = script:FindFirstAncestor("Plugin")

local Fusion = require(plugin.Packages.Fusion)
local Children = Fusion.Children

local Tag = require(plugin.Components.Tag)

return function(target)
    print(typeof(Tag))
    local header = Tag {
        Position = UDim2.fromScale(0.15, 0.15),
        Size = UDim2.fromOffset(108, 35),
        Parent = target,
        TagTextContent = "enum"
    }

    return function()
        header:Destroy()
    end
end