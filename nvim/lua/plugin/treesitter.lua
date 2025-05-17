return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VeryLazy',
		build = ':TSUpdate',
		opts = {
			ensure_installed = {
				'markdown',
				'markdown_inline',
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
		config = function (_, opts)
			require('nvim-treesitter.configs').setup(opts)
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
							[keymap_prefix.treesitter .. 'sn'] = {
								query = '@parameter.inner',
								desc = 'Swap the parameter with previous one',
							},
						},
						swap_previous = {
							[keymap_prefix.treesitter .. 'sp'] = {
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
							[keymap_prefix.treesitter .. 'df'] = {
								query = '@function.outer',
								desc = 'Show the definition of function',
							},
							[keymap_prefix.treesitter .. 'dc'] = {
								query = '@class.outer',
								desc = 'Show the definition of class',
							},
						},
					},
				},
			}
		end,
	},
	{
		'Wansmer/treesj',
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
			{
				keymap_prefix.treesitter .. 'st',
				function ()
					require 'treesj'.toggle()
				end,
				desc = 'Toggle split/join',
			},
			{
				keymap_prefix.treesitter .. 'ss',
				function ()
					require 'treesj'.split()
				end,
				desc = 'Split',
			},
			{
				keymap_prefix.treesitter .. 'sj',
				function ()
					require 'treesj'.join()
				end,
				desc = 'Join',
			},
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
			max_join_length = 10000,
		},
	},
}
