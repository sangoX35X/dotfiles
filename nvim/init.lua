function _G.debug_inspect (...)
	Snacks.debug.inspect(...)
end

function _G.debug_backtrace ()
	Snacks.debug.backtrace()
end

vim.print = _G.debug_inspect

do
	---@type string
	local random_bytes = vim.uv.random(8)
	---@type number
	local random_seed = 0
	for i = 1, #random_bytes do
		random_seed = random_seed * 256 + random_bytes:byte(i)
	end
	math.randomseed(random_seed)
end

if vim.loader then
	vim.loader.enable()
end

if vim.env.KEYBOARD_LAYOUT == 'colemak' then
	vim.g.colemak = true
end

require 'config'
