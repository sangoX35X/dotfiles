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
					position = 'right',
				},
			},
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = imap_prefix .. '<C-y>',
					accept_word = imap_prefix .. '<C-w>',
					accept_line = imap_prefix .. '<C-l>',
					next = imap_prefix .. '<C-n>',
					prev = imap_prefix .. '<C-p>',
					dismiss = imap_prefix .. '<C-e>',
				},
			},
			copilot_model = 'gpt-4o-copilot',
		},
		keys = {
			{
				keymap_prefix.toggle .. 'c',
				function ()
					require 'copilot.suggestion'.toggle_auto_trigger()
				end,
				desc = 'Toggle copilot auto suggestion',
			},
		},
	},
}
