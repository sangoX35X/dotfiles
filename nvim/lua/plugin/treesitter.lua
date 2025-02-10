local keymap_prefix = '<leader>t'

return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VeryLazy',
		config = function ()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = 'all',
				auto_install = true,
			}
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		event = 'VeryLazy',
		dependences = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function ()
			require 'nvim-treesitter.configs'.setup {
				textobjects = {
					select = {
						enable = false,
					},
					swap = {
						enable = true,
						swap_next = {
							[keymap_prefix .. 'sn'] = {
								query = '@parameter.inner',
								desc = 'Swap the parameter with previous one',
							},
						},
						swap_previous = {
							[keymap_prefix .. 'sp'] = {
								query = '@parameter.inner',
								desc = 'Swap the parameter with next one',
							},
						},
					},
					move = {
						enable = false,
					},
					lsp_interop = {
						enable = true,
						floating_preview_opts = {
							border = 'rounded',
						},
						peek_definition_code = {
							[keymap_prefix .. 'df'] = {
								query = '@function.outer',
								desc = 'Show the definition of function'
							},
							[keymap_prefix .. 'dc'] = {
								query = '@class.outer',
								desc = 'Show the definition of class'
							},
						},
					},
				},
			}
		end,
	},
	{
		'Wansmer/treesj',
		enable = true,
		keys = {
			{
				'gS',
				function ()
					if require 'treesj.langs'.presets[vim.bo.ft] then
						require 'treesj'.toggle()
					else
						MiniSplitjoin.toggle()
					end
				end,
				desc = 'Toggle arguments',
			},
			{ keymap_prefix .. 'st', function () require 'treesj'.toggle() end, desc = 'Toggle split/join' },
			{ keymap_prefix .. 'ss', function () require 'treesj'.split() end, desc = 'Split' },
			{ keymap_prefix .. 'sj', function () require 'treesj'.join() end, desc = 'Join' },
		},
		cmd = {
			'TSJToggle',
			'TSJSplit',
			'TSJJoin',
		},
		dependences = {
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {
		},
	},
}
