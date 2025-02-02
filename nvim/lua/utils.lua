---@type table<string, function>
local M = {}

---@alias utils.Keymap.mode string
---@alias utils.Keymap.lhs string
---@alias utils.Keymap.rhs string | fun(): string | nil

---@class (exact) utils.Keymap.opt
---@field desc? string
---@field remap? boolean
---@field silent? boolean
---@field expr? boolean
---@field buffer? number

---@class (exact) utils.Keymap.map: utils.Keymap.opt
---@field [1] utils.Keymap.rhs

---@param table table<utils.Keymap.mode, table<utils.Keymap.lhs, utils.Keymap.map | utils.Keymap.rhs>>
---@return nil
M.keymap_set_from_table = function (table)
	for mode, keymap in pairs(table) do
		---@type string[]
		local m = {}

		for i = 1, #mode do
			m[i] = mode:sub(i, i)
		end

		for lhs, map in pairs(keymap) do
			---@type utils.Keymap.rhs
			local rhs
			---@type utils.Keymap.opt
			local o = {}

			if type(map) == 'string' then
				rhs = map
			elseif type(map) == 'table' then
				rhs = map[1]
				o.desc = map.desc
				o.remap = map.remap
				o.silent = map.silent
				o.expr = map.expr
				o.buffer = map.buffer
			end

			vim.keymap.set(m, lhs, rhs, o)
		end
	end
end

return M
