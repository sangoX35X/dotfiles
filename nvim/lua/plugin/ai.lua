local nmap_prefix = '<leader>c'
local imap_prefix = '<C-c>'

return {
	{
		'zbirenbaum/copilot.lua',
		cond = vim.fn.executable 'node' == 1,
		event = 'VeryLazy',
		opts = {
			panel = {
				auto_refresh = true,
				keymap = {
					accept = '<localleader>a',
					refresh = '<localleader>r',
					open = imap_prefix .. 'p',
				},
				layout = {
					position = 'vertical',
				},
			},
			suggestion = {
				keymap = {
					accept = imap_prefix .. '<C-y>',
					accept_word = imap_prefix .. '<C-w>',
					accept_line = imap_prefix .. '<C-l>',
					next = imap_prefix .. '<C-n>',
					prev = imap_prefix .. '<C-p>',
					dismiss = imap_prefix .. '<C-e>',
				},
			},
		},
		config = true,
		keys = {
			{
				nmap_prefix .. 'a',
				function ()
					require 'copilot.suggestion'.toggle_auto_trigger()
				end,
				desc = 'Toggle auto suggestion',
			},
		},
	},
}
