local plugin = script.Parent.Parent.Parent
local components = plugin.Components
local uiUtils = components.UIUtils

local getValidUiAnchor = require(uiUtils.getValidUiAnchor)

local function fromCameraViewport(instance)
    local guiSize = instance.Size

    local guiWidth = guiSize.Width
    local guiHeight = guiSize.Height

    local camera = workspace.CurrentCamera
    local viewportSize = camera.ViewportSize

    return UDim2.fromOffset(
        guiWidth.Scale * viewportSize.X + guiWidth.Offset,
        guiHeight.Scale * viewportSize.Y + guiWidth.Offset
    )
end

local function fromRelativeAbsoluteSize(mainInstanceSize, relativeAbsoluteSize)
    local guiWidth = mainInstanceSize.Width
    local guiHeight = mainInstanceSize.Height

    return UDim2.fromOffset(
        guiWidth.Scale * relativeAbsoluteSize.X + guiWidth.Offset,
        guiHeight.Scale * relativeAbsoluteSize.Y + guiHeight.Offset
    )
end


local function scaleToOffset(instance : GuiObject)
    local parentInstance = instance.Parent
    if parentInstance:IsA("GuiObject") then
        local newParentInstance, noneAutomaticSize = getValidUiAnchor(parentInstance)
        if noneAutomaticSize then
            return fromRelativeAbsoluteSize(instance.Size, newParentInstance.AbsoluteSize)
        end
    end
    return fromCameraViewport(instance)
end

return {
    fromCameraViewport = fromCameraViewport,
    fromRelativeAbsoluteSize = fromRelativeAbsoluteSize,
    fromUiAnchor = scaleToOffset
}