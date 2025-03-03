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
}
