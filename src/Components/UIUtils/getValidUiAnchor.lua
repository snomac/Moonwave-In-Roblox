local function getParentYields(instance : Instance)
    if instance.Parent == nil then
        instance:GetPropertyChangedSignal("Parent"):Wait()
    end
    return instance.Parent
end

local function getValidUiAnchor(instance : Instance, lastIterationInstance : Instance?) : GuiObject
    if instance == nil then
        return lastIterationInstance
    end
    local parentInstance = getParentYields(instance)
    if parentInstance == nil or not parentInstance:IsA("GuiObject") then
        return instance, false
    end
    if
     instance:IsA("GuiObject")
     and instance.AutomaticSize == Enum.AutomaticSize.None
    then
        return instance, true
    end
    return getValidUiAnchor(parentInstance, instance)
end

return getValidUiAnchor