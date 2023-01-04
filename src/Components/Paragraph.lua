local plugin = script.Parent.Parent

local Fusion = require(plugin.Packages.Fusion)
local Hydrate = Fusion.Hydrate

local Label = require(plugin.Components.Label)

type ParagraphProps = {
    [any]: any
}

local function Paragraph(props : ParagraphProps)

    local label = Label {
        TextSize = 20,
        TextWrapped = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSans,
        AutomaticSize = Enum.AutomaticSize.XY,
    }

    return Hydrate(label)(props)
end

return Paragraph