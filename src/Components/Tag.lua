local TextService = game:GetService("TextService")

local plugin = script:FindFirstAncestor("Plugin")
local components = plugin.Components

local Fusion = require(plugin.Packages.Fusion)

local Label = require(components.Label)
local TextScaled = require(components.UIUtils.TextScaled)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children
local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate
local Ref = Fusion.Ref

type TagProps = {
    TagTextContent : string,
    TagColor : Color3?,
    [any]: any
}

local COMPONENT_ONLY_PROPERTIES = {
    "TagTextContent",
    "TagColor"
}

local function Tag(props : TagProps)
    local tagRef = Value()

    local hydrateProps = table.clone(props)
    for index, propertyName in COMPONENT_ONLY_PROPERTIES do
        hydrateProps[propertyName] = nil
    end

    return Hydrate(New "ImageLabel" {
        -- TODO: change this as a Computed function that scales with the size
        Size = Computed(function()
            local tag = tagRef:get()
            local xSizeToAdd = 0

            if tag then
                for index, gui in tag:GetDescendants() do
                    if gui:IsA("GuiBase") then
                        xSizeToAdd += gui.Size.Width.Offset
                    end
                end
            end

            return UDim2.fromOffset(35, math.min(xSizeToAdd, 25))
        end),
        ScaleType = Enum.ScaleType.Slice,
        Image = "http://www.roblox.com/asset/?id=11259300053",
        -- TODO: will do these as a Ref-Computed function later
        SliceCenter = Rect.new(25, 0, (props.Size.Width.Offset or 77) - 36, (props.Size.Height.Offset or 35)),
        BackgroundTransparency = 1,
        ImageColor3 = props.TagColor or Color3.fromRGB(255, 255, 255),
        [Children] = Label {
            TextSize = 20,
            Text = props.TagTextContent,
            Size = UDim2.new(0, 0, 0, 0),
            Font = Enum.Font.SourceSans,
            TextColor3 = Color3.new(255, 255, 255),
            AnchorPoint = Vector2.new(0, 0),
            Position = Computed(function()
                return UDim2.new(0, 0, 0, 0)
            end),
            [TextScaled] = Value(true)
        },
        [Ref] = tagRef
    })(hydrateProps)
end

return Tag