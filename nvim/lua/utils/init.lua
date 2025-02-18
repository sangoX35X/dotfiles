---@type table<string, function>
local M = {}

---@alias utils.Keymap.mode string
---@alias utils.Keymap.lhs string
---@alias utils.Keymap.rhs string | fun(): string

---@class (exact) utils.Keymap.opt
---@field desc? string
---@field remap? boolean
---@field silent? boolean
---@field expr? boolean
---@field buffer? number

---@class (exact) utils.Keymap.map: utils.Keymap.opt
---@field [1] utils.Keymap.rhs

---@class (exact) utils.Keymap.global_opt: utils.Keymap.opt
---@field prefix? string

---@param table table<utils.Keymap.mode | number, table<utils.Keymap.lhs, utils.Keymap.map | utils.Keymap.rhs> | utils.Keymap.global_opt>
---@return nil
M.set_keymap_from_table = function (table)
	---@type utils.Keymap.global_opt
	local g_opt = {}

	if table[1] then
		g_opt = table[1]
		table[1] = nil
	end
	if not g_opt.prefix then
		g_opt.prefix = ''
	end

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

			for k, v in pairs(o) do
				if not v then
					o[k] = g_opt[k]
				end
			end

			vim.keymap.set(m, g_opt.prefix .. lhs, rhs, o)
		end
	end
end

M.del_keymap_from_table = function (keymap_table)
	local g_opt = keymap_table[1] or {}
	keymap_table[1] = nil

	for mode_str, keymaps in pairs(keymap_table) do
		for i = 1, #mode_str do
			local mode = mode_str:sub(i, i)
			for key, maps in pairs(keymaps) do
				local current
				local bufnr = maps.buffer or g_opt.buffer
				if bufnr or bufnr == 0 then
					if bufnr == true then
						bufnr = 0
					end
					current = vim.api.nvim_buf_get_keymap(bufnr, mode)
				else
					current = vim.api.nvim_get_keymap(mode)
				end
				local is_exist
				for _, map in ipairs(current) do
					if map.lhs == maps[1] then
						is_exist = true
						break
					end
				end
				if is_exist then
					vim.keymap.del(mode, maps[1], { buffer = bufnr })
				end
			end
		end
	end
end

---@param ... table
---@return table
M.marge_map = function (...)
	---@type table
	local result = {}

	for _, t in ipairs {...} do
		for k, v in pairs(t) do
			if type(v) == 'table' or type(result[k]) == 'table' then
				local dest = result[k]
				local src = v
				if type(dest) ~= 'table' then
					dest = { dest }
				elseif type(src) ~= 'table' then
					src = { src }
				end
				result[k] = M.marge_map(dest, src)
			else
				result[k] = v
			end
		end
	end

	return result
end

---@param ... table
---@return table
M.marge_list = function (...)
	---@type table
	local result = {}

	for _, list in ipairs {...} do
		for _, elem in ipairs(list) do
			table.insert(result, elem)
		end
	end

	return result
end

return M
