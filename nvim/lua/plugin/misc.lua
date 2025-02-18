return {
	{
		'vim-jp/vimdoc-ja',
		keys = {
			{ mode = 'c', 'h' },
		},
	},
	{
		"uga-rosa/translate.nvim",
		keys = {
			{ mode = { 'n', 'x' }, '<leader>Tsj', '<cmd>Translate ja -output=split<cr>' },
			{ mode = { 'n', 'x' }, '<leader>Tfj', '<cmd>Translate ja -output=floating<cr>' },
			{ mode = { 'n', 'x' }, '<leader>Tij', '<cmd>Translate ja -output=insert<cr>' },
			{ mode = { 'n', 'x' }, '<leader>Trj', '<cmd>Translate ja -output=replace<cr>' },
			{ mode = { 'n', 'x' }, '<leader>Tyj', '<cmd>Translate ja -output=register<cr>' },
		},
		opts = {
			default = {
			},
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
}
