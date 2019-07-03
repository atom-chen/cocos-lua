local M = {}
M.__index = M

function M.new()
    return setmetatable({assets = {}}, M)
end

function M:__pairs()
    return next, self.assets
end

function M:fromPath(path)
    self.assets[path] = true
    return self
end

function M:fromSWF(swfPath)
    swfPath = string.gsub(swfPath, "/", ".")
    swfPath = string.gsub(swfPath, "%.swf$", "")
    local data = require(swfPath)
    for _, path in ipairs(data.files) do
        self.assets[path] = true
    end
    return self
end

function M:fromLayout(symbol)
    error('TODO')
    -- for _, path in ipairs(ui.get_data(symbol).files) do
    --     assets[path] = true
    -- end
    -- return self
end

function M:fromFUI(fuiPackage)
    error('TODO')
end

function M:fromDB(dbPath)
    error('TODO')
end

function M:fromRange(fmt, from, to)
    for i = from, to do
        self.assets[string.format(fmt, i)] = true
    end
    return self
end

function M:fromArray(arr, from, to)
    from = from or 1
    to = to or #arr
    for i = from, to do
        local path = arr[i]
        if path then
            self.assets[path] = true
        else
            break
        end
    end
    return self
end

function M:merge(other)
    for k, v in pairs(other) do
        self.assets[k] = v
    end
    return self
end

return M