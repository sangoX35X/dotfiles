if vim.loader then
	vim.loader.enable()
end

if vim.env.KEYBOARD_LAYOUT == 'colemak' then
	vim.g.colemak = true
end

require 'config'
