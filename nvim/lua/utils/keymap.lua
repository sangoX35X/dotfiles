local M = {}

---@alias utils.keymap.mode_string string
---@alias utils.keymap.mode string
---@alias utils.keymap.lhs string
---@alias utils.keymap.rhs string

---@class (exact) utils.keymap.map: vim.keymap.set.Opts
---@field [1] utils.keymap.rhs

---@class (exact) utils.keymap.default_option: vim.keymap.set.Opts
---@field prefix? string

---@param default? utils.keymap.default_option
---@param keymap_table table<utils.keymap.mode_string, table<utils.keymap.lhs, utils.keymap.rhs|vim.keymap.set.Opts>>
---@return nil
M.set_by_table = function (default, keymap_table)
	if not default then
		default = {}
	end

	---@type string
	local prefix = default.prefix or ''

	---@type utils.keymap.mode_string, table<utils.keymap.lhs, utils.keymap.rhs|utils.keymap.map>
	for mode_string, keymap in pairs(keymap_table) do
		---@type utils.keymap.mode[]
		local modes = {}

		for i = 1, #modes do
			table.insert(modes, string.sub(mode_string, i, i))
		end

		---@type utils.keymap.lhs, utils.keymap.rhs|utils.keymap.map
		for lhs, rhs_or_map in pairs(keymap) do
			---@type utils.keymap.rhs
			local rhs
			---@type vim.keymap.set.Opts
			local options = setmetatable({}, { __index = default })
			if type(rhs_or_map) == 'string' then
				rhs = rhs_or_map
			else
				for key, value in pairs(rhs_or_map) do
					if key == 1 then
						rhs = value
					else
						options[key] = value
					end
				end
			end
			vim.keymap.set(modes, prefix .. lhs, rhs, options)
		end
	end
end

return M
