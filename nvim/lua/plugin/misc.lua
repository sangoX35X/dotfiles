return {
	{
		'vim-jp/vimdoc-ja',
		keys = {
			{ mode = 'c', 'h' },
		},
	},
	{
		'uga-rosa/translate.nvim',
		cmd = {
			'Translate',
		},
		keys = {
			{ mode = { 'n', 'x' }, keymap_prefix.translate .. 'sj', '<cmd>Translate ja -output=split<cr>' },
			{ mode = { 'n', 'x' }, keymap_prefix.translate .. 'fj', '<cmd>Translate ja -output=floating<cr>' },
			{ mode = { 'n', 'x' }, keymap_prefix.translate .. 'ij', '<cmd>Translate ja -output=insert<cr>' },
			{ mode = { 'n', 'x' }, keymap_prefix.translate .. 'rj', '<cmd>Translate ja -output=replace<cr>' },
			{ mode = { 'n', 'x' }, keymap_prefix.translate .. 'yj', '<cmd>Translate ja -output=register<cr>' },
		},
		opts = {
			default = {},
			preset = {
				output = {
					split = {
						filetype = 'translate-split',
						append = true,
					},
					floating = {
						border = 'rounded',
						filetype = 'translate-floating',
					},
				},
			},
		},
	},
	{
		'Bekaboo/dropbar.nvim',
		event = 'VeryLazy',
		opts = {},
		keys = {
			{
				desc = 'Pick breadcrumbs',
				keymap_prefix.filer .. 'b',
				function ()
					require 'dropbar.api'.pick()
				end,
			},
		},
	},
}
