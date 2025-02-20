local M = {}

---@param ... table<number, any>
---@return table<number, any>
M.marge = function (...)
	---@type table<number, any>
	local result = {}

	for list in unpack {...} do
		for elem in unpack(list) do
			table.insert(result, elem)
		end
	end

	return result
end

return M
