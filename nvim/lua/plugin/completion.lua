return {
	{
		'hrsh7th/nvim-cmp',
		-- enabled = false,
		version = false,
		event = { 'InsertEnter', 'CmdlineEnter' },
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-emoji',
			'abeldekat/cmp-mini-snippets',
			'uga-rosa/cmp-skkeleton',
		},
		config = function (_, _)
			local cmp = require('cmp')

			cmp.setup {
				snippet = {
					expand = function (args)
						local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
						insert { body = args.body }
						cmp.resubscribe { 'TextChangedI', 'TextChangedP' }
						require('cmp.config').set_onetime { source = {} }
					end,
				},
				mapping = cmp.mapping.preset.insert {
					['<C-e>'] = cmp.mapping.abort(),
				},
				sources = cmp.config.sources {
					{ name = 'nvim_lsp' },
					{ name = 'mini_snippets' },
					{ name = 'path' },
					{ name = 'buffer' },
					{ name = 'skkeleton' },
					{
						name = 'emoji',
						trigger_characters = { ':' },
					},
				},
				view = {
					entries = {
						follow_cursor = true,
					},
				},
				formatting = {
					format = function (entry, item)
						local kind_icons = {
							Array = ' ',
							Boolean = '󰨙 ',
							Class = ' ',
							Codeium = '󰘦 ',
							Color = ' ',
							Control = ' ',
							Collapsed = ' ',
							Constant = '󰏿 ',
							Constructor = ' ',
							Copilot = ' ',
							Enum = ' ',
							EnumMember = ' ',
							Event = ' ',
							Field = ' ',
							File = ' ',
							Folder = ' ',
							Function = '󰊕 ',
							Interface = ' ',
							Key = ' ',
							Keyword = ' ',
							Method = '󰊕 ',
							Module = ' ',
							Namespace = '󰦮 ',
							Null = ' ',
							Number = '󰎠 ',
							Object = ' ',
							Operator = ' ',
							Package = ' ',
							Property = ' ',
							Reference = ' ',
							Snippet = '󱄽 ',
							String = ' ',
							Struct = '󰆼 ',
							Supermaven = ' ',
							TabNine = '󰏚 ',
							Text = ' ',
							TypeParameter = ' ',
							Unit = ' ',
							Value = ' ',
							Variable = '󰀫 ',
						}
						if kind_icons[item.kind] then
							item.kind = kind_icons[item.kind]
						end

						return item
					end,
				},
			}
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' },
					{ name = 'skkeleton' },
				},
			})
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'path' },
					{ name = 'cmdline' },
					{ name = 'skkeleton' },
				},
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
}
