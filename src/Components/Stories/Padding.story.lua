local plugin = script.Parent.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local Padding = require(plugin.Components.UIUtils.Padding)

return function (target)
    local box = New "Frame" {
        Size = UDim2.fromOffset(300, 100),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = target,
        [Children] = {
            Padding {PaddingAll = 15},
            New "TextLabel" {
                Size = UDim2.fromScale(1, 1),
                BorderSizePixel = 1,
            }
        }
    }

    return function ()
        box:Destroy()
    end
end