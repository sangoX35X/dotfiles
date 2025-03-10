return {
	{
		'Shougo/pum.vim',
		config = function ()
			vim.api.nvim_set_hl(0, 'PumFloatNormal', { link = 'NormalFloat' })
			vim.fn['pum#set_option'] {
				border = 'rounded',
				direction = 'auto',
				follow_cursor = true,
				highlight_normal_menu = 'PumFloatNormal',
				highlight_matches = 'PumFloatMatch',
				highlight_preview = 'PumFloatNormal',
				item_orders = { 'menu', 'space', 'space', 'kind', 'space', 'space', 'abbr' },
				max_columns = {
					-- kind = 1,
					-- menu = 1,
				},
				max_height = 8,
				offset_cmdrow = 2,
				padding = true,
				preview_border = 'rounded',
				preview_delay = 0,
				scrollbar_char = '',
			}
		end,
	},
	{
		'denops-popup-preview.vim',
		opts = {
			border = 'rounded',
			supportVsnip = false,
			supportUltisnips = false,
			delay = 200,
		},
		config = function (_, opts)
			-- set options
			vim.g.popup_preview_config = opts
			-- set highlights
			vim.api.nvim_set_hl(0, 'PopupPreviewBorder', { link = 'FloatBorder' })
			-- init
			vim.fn['popup_preview#enable']()
		end,
	},
	{
		'Shougo/ddc.vim',
		dependencies = {
			-- ui
			'Shougo/ddc-ui-pum',
			-- source
			'Shougo/ddc-around',
			'LumaKernel/ddc-file',
			'Shougo/ddc-source-lsp',
			'matsui54/ddc-source-buffer',
			'gamoutatsumi/ddc-emoji',
			'tani/ddc-path',
			-- filter
			'tani/ddc-fuzzy',
			'ttak0422/ddc-sorter_itemsize',
			'haxibami/ddc-filter-converter_color',
			-- misc
			'Shougo/pum.vim',
			'denops-popup-preview.vim',
		},
		event = {
			{
				event = 'User',
				pattern = 'DenopsReady',
			},
		},
		config = function ()
			local source_kind_table = {
				lsp = {
					-- lsp
					'Text',
					'Method',
					'Function',
					'Constructor',
					'Field',
					'Variable',
					'Class',
					'Interface',
					'Module',
					'Property',
					'Unit',
					'Value',
					'Enum',
					'Keyword',
					'Snippet',
					'Color',
					'File',
					'Reference',
					'Folder',
					'EnumMember',
					'Constant',
					'Struct',
					'Event',
					'Operator',
					'TypeParameter',
				},
				default = {
					'file',
					'directory',
				},
			}
			local kind_labels = {
				icons = {},
				highlights = {},
			}
			for category, names in pairs(source_kind_table) do
				for _, name in ipairs(names) do
					local icon, hi = MiniIcons.get(category, name)
					kind_labels.icons[name] = icon
					kind_labels.highlights[name] = hi
				end
			end
			local function add_kind_label (label_table)
				for name, label in pairs(label_table) do
					kind_labels.icons[name] = label[1]
					kind_labels.highlights[name] = label[2]
				end
			end
			add_kind_label {
				symlink = {
					'',
				},
				symlinkFile = {
					'',
				},
				symlinkDirectory = {
					'',
				},
			}
			vim.fn['ddc#custom#patch_global']('ui', 'pum')
			vim.fn['ddc#custom#patch_global'] {
				autoCompleteEvents = {
					'BufEnter',
					'TextChangedI',
					'TextChangedP',
					'InsertEnter',
				},
				backspaceCompletion = true,
				filterOptions = {},
				filterParams = {
					converter_kind_labels = {
						kindLabels = kind_labels.icons,
						kindHlGroups = kind_labels.highlights,
					},
					converter_fuzzy = {
						hlGroup = 'Special',
					},
				},
				postFilters = {
					'sorter_fuzzy',
					-- 'sorter_itemsize',
				},
				sources = {
					'lsp',
					'file',
					'path',
					'emoji',
					'around',
					'buffer',
				},
				sourceOptions = {
					_ = {
						matchers = {
							'matcher_fuzzy',
						},
						sorters = {
							'sorter_itemsize',
						},
						converters = {
							'converter_fuzzy',
						},
						minAutoCompleteLength = 1,
						ignoreCase = true,
					},
					around = {
						mark = '',
						minAutoCompleteLength = 3,
						minKeywordLength = 3,
						ignoreCase = false,
					},
					buffer = {
						mark = '',
						minAutoCompleteLength = 3,
						minKeywordLength = 3,
						ignoreCase = false,
					},
					emoji = {
						dup = 'keep',
						mark = '󰞅',
						matchers = {
							'emoji',
						},
						sorters = {},
						converters = {},
						keywordPattern = ':\\w*',
						minAutoCompleteLength = 4,
					},
					file = {
						mark = '󰈔',
						isVolatile = true,
						keywordPattern = '[\\w.-]*',
						converters = {
							'converter_kind_labels',
							'converter_fuzzy',
						},
					},
					lsp = {
						dup = 'keep',
						mark = '',
						converters = {
							'converter_kind_labels',
							'converter_color',
							'converter_fuzzy',
						},
					},
					path = {
						mark = '󰈞',
						keywordPattern = '[\\w./-]*',
					},
					skkeleton = {
						mark = '',
						matchers = {},
						sorters = {},
						converters = {},
						isVolatile = true,
						minAutoCompleteLength = 1,
					},
				},
				sourceParams = {
					file = {
						disableMenu = true,
						displayDir = 'directory',
						displaySym = 'symlink',
						displaySymFile = 'symlinkFile',
						displaySymDir = 'symlinkDirectory',
					},
					lsp = {
						snippetEngine = vim.fn['denops#callback#register'](function (body)
							MiniSnippets.default_insert { body = body }
						end),
					},
				},
			}
			vim.api.nvim_create_autocmd('User', {
				pattern = 'skkeleton-enable-pre',
				callback = function ()
					vim.b.prev_ddc_config = vim.fn['ddc#custom#get_buffer']()
					vim.fn['ddc#custom#patch_buffer'] {
						sources = {
							'skkeleton',
						},
						postFilters = {},
					}
				end,
			})
			vim.api.nvim_create_autocmd('User', {
				pattern = 'skkeleton-disable-pre',
				callback = function ()
					vim.fn['ddc#custom#set_buffer'](vim.b.prev_ddc_config)
					vim.b.prev_ddc_config = nil
				end,
			})
			vim.keymap.set('i', '<C-x>', '<cmd>call ddc#hide()<Cr><C-x>')

			vim.fn['ddc#enable'] {
				context_filetype = 'treesitter',
			}
		end,
	},
}
