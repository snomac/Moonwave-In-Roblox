local TextService = game:GetService("TextService")

local plugin = script:FindFirstAncestor("Plugin")
local Fusion = require(plugin.Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children
local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate
local Ref = Fusion.Ref

type HeaderProps = {
    [any]: any
}

local function HeaderContainer(props : HeaderProps)
    -- NOTES:
    -- For standardization, these are the font sizes for headers:
    -- h1s are 40,
    -- h2s are 33,
    -- and h3s are 28.

    return Hydrate(New "Frame" {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        [Children] = Computed(function()
            return {
                New "UIListLayout" {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 20)
                }
            }
        end)
    })(props)
end

return HeaderContainer