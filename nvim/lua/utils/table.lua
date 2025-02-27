local M = {}

local stdtable = table

---@param table table<any, any>
---@param ... any
---@return any the value
function M.get_nested(table, ...)
	local keys = {...}

	if #keys == 0 then
		return table
	end

	if type(table) ~= 'table' then
		return nil
	end

	local head = stdtable.remove(keys, 1)

	return M.get_nested(table[head], unpack(keys))
end

return M
