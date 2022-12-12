local plugin = script.Parent.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local OnChange = Fusion.OnChange

local SearchBox = require(plugin.Components.SearchBox)

return function (target)
    local box = New "Frame" {
        Size = UDim2.fromOffset(300, 100),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = target,
        [Children] = SearchBox {
            Position = UDim2.fromScale(0.5, 0.5),
            [OnChange "Text"] = function(newText)
                print(newText)
            end
        }
    }

    return function()
        box:Destroy()
    end
end