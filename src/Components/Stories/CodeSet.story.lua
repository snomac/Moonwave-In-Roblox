local plugin = script.Parent.Parent.Parent

local CodeSet = require(plugin.Components.CodeSet)
local TextHugged = require(plugin.Components.UIUtils.TextHugged)

local Fusion = require(plugin.Packages.Fusion)

local codeSample = [[
local plugin = script.Parent.Parent.Parent

local CodeSet = require(plugin.Components.CodeSet)
local TextHugged = require(plugin.Components.UIUtils.TextHugged)

local Fusion = require(plugin.Packages.Fusion)

return function(target)
    local codeSet = CodeSet {
        Parent = target,
        HeaderText = "A code sample of this script"
    }
    return function()
        codeSet:Destroy()
    end
end]]

return function(target)
    local codeSet = CodeSet {
        Parent = target,
        HeaderText = "A code sample of this script!",
        CodeBlockText = codeSample
    }
    return function()
        codeSet:Destroy()
    end
end