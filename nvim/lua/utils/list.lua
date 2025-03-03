local M = {}

---@param ... table<number, any>
---@return table<number, any>
M.marge = function (...)
	---@type table<number, any>
	local result = {}

	for _, list in ipairs { ... } do
		for _, elem in ipairs(list) do
			table.insert(result, elem)
		end
	end

	return result
end

return M
