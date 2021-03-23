function _G.copy(obj, seen)
    if type(obj) ~= "table" then
        return obj
    end
    if seen and seen[obj] then
        return seen[obj]
    end
    local s = seen or {}
    local res = {}
    s[obj] = res
    for k, v in next, obj do
        res[copy(k, s)] = copy(v, s)
    end
    return setmetatable(res, getmetatable(obj))
end

function _G.P(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

function _G.R(package)
    package.loaded[package] = nil
    return require(package)
end

function _G.T()
    print(require("nvim-treesitter.ts_utils").get_node_at_cursor():type())
end
