return {
	{
		'folke/edgy.nvim',
		event = 'VeryLazy',
		opts = {
			left = {},
			bottom = {},
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
			top = {},
			animate = {
				enabled = false,
			},
			exit_when_last = true,
		},
	},
	{
		'j-hui/fidget.nvim',
		opts = {
			notification = {
				view = {
					group_separator = '- ─ ────',
				},
			},
		},
	},
	{
		'OXY2DEV/markview.nvim',
		cmd = { 'Markview' },
		opts = {
			preview = {
				icon_provider = 'mini',
			},
		},
	},
	{
		'rachartier/tiny-inline-diagnostic.nvim',
		event = 'LspAttach',
		keys = {
			{
				keymap_prefix.toggle .. 'd',
				function ()
					require('tiny-inline-diagnostic').toggle()
				end,
				desc = 'Toggle inline diagnostic',
			},
		},
		opts = {
			signs = {
				left = '',
				right = '',
				diag = '',
				arrow = '     ',
				vertical = ' │',
				vertical_end = ' ╰',
			},
			options = {
				show_source = {
					enabled = true,
					if_many = true,
				},
				set_arrow_to_diag_color = true,
				multilines = {
					enabled = true,
					always_show = true,
				},
				show_all_diags_on_cursorline = true,
				over_flow = {
					padding = 1,
				},
				break_line = {
					-- enabled = true,
				},
				---@param diagnostic vim.Diagnostic
				---@return string
				format = function (diagnostic)
					return ('%s [%s: %s]'):format(diagnostic.message, diagnostic.source, diagnostic.code)
				end,
			},
		},
		config = function (_, opts)
			require('tiny-inline-diagnostic').setup(opts)
			vim.diagnostic.config { virtual_text = false }
		end,
	},
}
