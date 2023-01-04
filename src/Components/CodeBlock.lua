local plugin = script.Parent.Parent
local Fusion = require(plugin.Packages.Fusion)
local Highlighter = require(plugin.Packages.Highlighter)
local TextHugged = require(plugin.Components.UIUtils.TextHugged)

local New = Fusion.New
local Value = Fusion.Value
local Hydrate = Fusion.Hydrate

type CodeBlockProps = {
    [any]: any
}

local function CodeBlock(props : CodeBlockProps)
    local codeBlock = New "TextLabel" {
        AnchorPoint = Vector2.new(0, 0),
        Font = Enum.Font.RobotoMono,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        [TextHugged] = Value("Y"),
    }

    task.defer(function()
        local highlight = Highlighter.highlight {
            textObject = codeBlock
        }
    end)

    return Hydrate(codeBlock)(props)
end

return CodeBlock