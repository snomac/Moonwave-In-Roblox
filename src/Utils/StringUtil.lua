--!strict
-- This ModuleScript finds the results inside strings or replaces them

type Array<T> = {[number] : T}
type Dictionary<T, U> = {[T]: U}

local StringUtil = {}

function StringUtil.getMatchingLocations(content : string, prompt : string, plain : boolean?) : Array<Array<number>>?
    local newString : string = content
    local output : Array<string>? = {}

    plain = plain or false

    for matchedString in string.gmatch(content, prompt) do
        table.insert(
            output,
            {string.find(newString, matchedString, 1, plain)}
        )
        newString = string.gsub(newString, prompt, " ", 1)
    end
    return if #output < 1 then nil else output
end

function StringUtil.matches(content : string, prompts : string | Array<string>, pattern : string?) : (number, string)
    pattern = pattern or "%w+"
    local matches : boolean = false

    local newString, patternsReplaced = string.gsub(content, pattern, prompts)

    if patternsReplaced >= 1 then
        matches = true
    end

    return matches, newString
end

function StringUtil.getMatchingStrings(contents : Array<string>, prompts : string | Array<string>, pattern : string?) : Array<{["1"]: string, ["2"]: number}>
    pattern = pattern or "%w+"
    local output = {}

    for index, content in contents do
        local matches = StringUtil.matches(content, prompts, pattern)

        if matches <= 1 then
            table.insert(output, {content, matches})
        end
    end

    return output
end

return StringUtil