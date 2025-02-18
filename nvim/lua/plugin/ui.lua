return {
	{
		'folke/edgy.nvim',
		event = 'VeryLazy',
		opts = {
			left = {
			},
			bottom = {
			},
			right = {
				{
					ft = 'help',
					title = function ()
						return MiniIcons.get('filetype', 'help') .. ' HELP'
					end,
					size = {
						width = 78,
					},
				},
			},
			top = {
			},
			animate = {
				enabled = false,
			},
			exit_when_last = true,
		},
	},
	{
		'j-hui/fidget.nvim',
		config = true,
	},
	{
		'OXY2DEV/markview.nvim',
		lazy = false,
		opts = {
			preview = {
				icon_provider = 'mini',
			},
		},
	},
}
