local plugin = script:FindFirstAncestor("Plugin")

local SearchBar = require(plugin.Components.SearchBar)

return function(target)
    print("starting")
    local searchBar = SearchBar {
        Parent = target,
        Size = UDim2.fromOffset(100, 35),
        Position = UDim2.fromScale(0.15, 0.15),
        onHelpButtonActivated = function()
            print("help button was pressed")
        end,
        onSearchTextChanged = function(newText)
            print(newText)
        end
    }

    print(searchBar.Size)

    return function()
        searchBar:Destroy()
    end
end