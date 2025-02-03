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
						return _G.MiniIcons.get('filetype', 'help') .. ' HELP'
					end,
					size = {
						width = 78,
					},
				},
			},
			top = {
			},
		},
		exit_when_last = true,
	},
}
