local plugin = script.Parent.Parent.Parent

local SearchBar = require(plugin.Components.SearchBar)

return function(target)
    local searchBar = SearchBar {
        Parent = target,
        Size = UDim2.fromOffset(100, 35),
        OnHelpButtonActivated = function()
            print("help button was pressed")
        end,
        OnSearchTextChanged = function(newText)
            print("PLACEHOLDER_RESULT_FUNCTION")
        end
    }

    return function()
        searchBar:Destroy()
    end
end