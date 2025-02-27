return {
	{
		'github/copilot.vim',
		event = 'VeryLazy',
		config = function()
			vim.g.copilot_no_tab_map = true
			require 'utils.keymap'.set_by_table(
				{
					prefix = '<C-c>',
				},
				{
					i = {
						['<C-y>'] = {
							function()
								vim.fn['copilot#Accept'] ''
							end,
							desc = "Accept the current copilot's suggestion"
						},
						['<C-e>'] = {
							'<Plug>(copilot-dismiss)',
							desc = "Dismiss the current copilot's suggestion",
						},
						['<C-n>'] = {
							'<Plug>(copilot-next)',
							desc = "Next copilot's suggestion",
						},
						['<C-p>'] = {
							'<Plug>(copilot-previous)',
							desc = "Previous copilot's suggestion",
						},
						['<C-c>'] = {
							'<Plug>(copilot-suggest)',
							desc = "Request a copilot's suggestion",
						},
						['<C-w>'] = {
							'<Plug>(copilot-accept-word)',
							desc = "Accept the next word of the current copilot's suggestion",
						},
						['<C-l>'] = {
							'<Plug>(copilot-accept-line)',
							desc = "Accept the next line of the current copilot's suggestion",
						},
					},
				}
			)
		end,
	},
}
