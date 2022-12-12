local TextService = game:GetService("TextService")
local plugin = script.Parent.Parent.Parent

local Fusion = require(plugin.Packages.Fusion)
local Children = Fusion.Children

local Admonition = require(plugin.Components.Admonition)
local Paragraph = require(plugin.Components.Paragraph)

return function(target)
    local admonition = Admonition {
        Parent = target,
        Position = UDim2.fromScale(0,0),
        AdmonitionType = "Info",
        [Children] = {
            Paragraph {
                Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc blandit purus eget odio volutpat, at tempor nisl sagittis. Suspendisse hendrerit elit accumsan dui tempor, non efficitur velit molestie. In sodales sed velit blandit bibendum. Cras elementum accumsan ante a tincidunt. Fusce eros sem, ultricies at nibh quis, aliquam bibendum velit. Pellentesque mattis aliquam libero a lobortis."
            },
            Paragraph {
                Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc blandit purus eget odio volutpat, at tempor nisl sagittis. Suspendisse hendrerit elit accumsan dui tempor, non efficitur velit molestie. In sodales sed velit blandit bibendum. Cras elementum accumsan ante a tincidunt. Fusce eros sem, ultricies at nibh quis, aliquam bibendum velit. Pellentesque mattis aliquam libero a lobortis."
            },
            Paragraph {
                Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc blandit purus eget odio volutpat, at tempor nisl sagittis. Suspendisse hendrerit elit accumsan dui tempor, non efficitur velit molestie. In sodales sed velit blandit bibendum. Cras elementum accumsan ante a tincidunt. Fusce eros sem, ultricies at nibh quis, aliquam bibendum velit. Pellentesque mattis aliquam libero a lobortis."
            },
        }
    }

    return function()
        admonition:Destroy()
    end
end