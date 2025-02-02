if vim.loader then
	vim.loader.enable()
end

if os.getenv('KEYBOARD_LAYOUT') == 'colemak' then
	vim.g.colemak = true
end

require 'config'
