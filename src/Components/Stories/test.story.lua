local function getPreviewFrame(instance : Instance)
    return instance:FindFirstAncestor("Preview")
end

local t = {{{{{},{}}}}}
local function getTwoTablesRecursive(tab : {})
    print(unpack(t), #t)
    if #tab == 2 then
        print("Returned")
        return tab
    end
    getTwoTablesRecursive(tab[1])
end

return function(target)
    local instance = Instance.new("Frame")
    instance.Parent = target


    print(getTwoTablesRecursive(t), "printing")

    print(getPreviewFrame(instance))
    return function()
        instance:Destroy()
    end
end