return {
	-- typst
	{
		{
			'kaarmu/typst.vim',
			ft = 'typst',
		},
		{
			'chomosuke/typst-preview.nvim',
			cmd = {
				'TypstPreview',
				'TypstPreviewFollowCursor',
				'TypstPreviewFollowCursorToggle',
				'TypstPreviewNoFollowCursor',
				'TypstPreviewStop',
				'TypstPreviewSyncCursor',
				'TypstPreviewToggle',
				'TypstPreviewUpdate',
			},
		},
	},
	-- markdown
	{
		{
			'iamcco/markdown-preview.nvim',
			ft = 'markdown',
			cond = vim.fn.executable('npm') == 1,
			build = 'cd app && npm install',
		},
	},
	-- sql
	{
		'Xemptuous/sqlua.nvim',
		cmd = { 'SQLua', 'SQLuaEdit' },
		config = function (_, opts)
			require('sqlua').setup(opts)
		end,
	},
}
