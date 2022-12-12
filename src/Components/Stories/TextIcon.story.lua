local plugin = script.Parent.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local TextIcon = require(plugin.Components.TextIcon)

return function(target)
    local textIcon = TextIcon {
        Parent = target,
        Text = "<i>i</i>",
        RichText = true,
        Font = Enum.Font.Merriweather
    }

    return function ()
        textIcon:Destroy()
    end
end