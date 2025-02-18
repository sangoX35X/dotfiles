return {
	-- LSP
	{
		{
			'neovim/nvim-lspconfig',
			event = 'VeryLazy',
			dependencies = {
				'j-hui/fidget.nvim',
			},
			config = function ()
				local lsp = require 'lspconfig'
				local lspbuf = vim.lsp.buf
				local servers = {
					'clangd',
					'lua_ls',
					'metals',
					'tinymist',
					-- 'haxe-language-server',
				}
				for _, server in ipairs(servers) do
					local ok, _ = pcall(require, 'lsp.' .. server)
					if not ok then
						require 'lsp.default'(server)
					end
				end

				require 'utils'.set_keymap_from_table {
					{
						prefix = '<leader>l',
						buffer = true,
					},
					n = {
						['jdc'] = {
							function () lspbuf.declaration { reuse_win = true } end,
							desc = 'Jump to the declaration of the symbol'
						},
						['jdf'] = {
							function () lspbuf.definition { reuse_win = true } end,
							desc = 'Jump to the definition of the symbol'
						},
						['f'] = {
							function () lspbuf.format { async = true } end,
							desc = 'Format the buffer with LS'
						},
						['h'] = {
							function () lspbuf.hover { border = 'rounded' } end,
							desc = 'Display hover information about the symbol'
						},
						['li'] = {
							function () lspbuf.implementation { reuse_win = true } end,
							desc = 'List all the implementations for the symbol'
						},
						['lcs'] = {
							function () lspbuf.incoming_calls() end,
							desc = 'List all the call sites of the symbol'
						},
						['lci'] = {
							function () lspbuf.outgoing_calls() end,
							desc = 'List all the items called by the symbol'
						},
						['lr'] = {
							function () lspbuf.references() end,
							desc = 'List all the references to the symbol'
						},
						['r'] = {
							function () lspbuf.rename() end,
							desc = 'Rename the symbol'
						},
						['s'] = {
							function () lspbuf.signature_help { silent = false, border = 'rounded' } end,
							desc = 'Display signature information about the symbol'
						},
						['jt'] = {
							function () lspbuf.type_definition() end,
							desc = 'Jump to the definition of the type of the symbol'
						},
						['lsb'] = {
							function () lspbuf.typehierarchy 'subtypes' end,
							desc = 'List all the subtypes of the symbol'
						},
						['lsp'] = {
							function () lspbuf.typehierarchy 'supertypes' end,
							desc = 'List all the supertypes of the symbol'
						},
					},
				}
				require 'utils'.set_keymap_from_table {
					n = {
						['K'] = {
							function () lspbuf.hover { border = 'rounded' } end,
							desc = 'Displays hover information about the symbol',
							buffer = true,
						},
					},
				}
				vim.api.nvim_create_autocmd(
					'ColorScheme',
					{
						callback = function ()
							vim.api.nvim_set_hl(0, 'LspReferenceTarget', {})
						end,
					}
				)
				vim.api.nvim_create_autocmd(
					{
						'CursorHold',
						'CursorHoldI',
					},
					{
						callback = function ()
							lspbuf.document_highlight()
						end
					}
				)
				vim.api.nvim_create_autocmd(
					{
						'CursorMoved',
						'CursorMovedI',
					},
					{
						callback = function ()
							lspbuf.clear_references()
						end
					}
				)
			end,
		},
		{
			'j-hui/fidget.nvim',
			opts = {
				view = {
					group_separator = '∙ - ─ ────',
				},
			},
		},
	},
	-- DAP
	{
		{
			'mfussenegger/nvim-dap',
			event = 'VeryLazy',
		},
		{
			'rcarriga/nvim-dap-ui',
			event = 'VeryLazy',
			dependencies = {
				'mfussenegger/nvim-dap',
			},
		},
	},
	-- Linter
	{
		{
			'mfussenegger/nvim-lint',
			event = 'VeryLazy',
			config = function ()
				local lint = require 'lint'
				lint.linters_by_ft = {
					c = {
						'clangtidy',
						'flawfinder',
					},
					cpp = {
						'clangtidy',
						'flawfinder',
					},
					clojure = {
						'cij-kondo',
						'joker',
					},
					cmake = {
						'cmakelint',
					},
					crystal = {
						'ameba',
					},
					css = {
						'biomejs',
						'stylelint',
					},
					elixir = {
						'credo',
					},
					fennel = {
						'fennel',
					},
					fish = {
						'fish',
					},
					gitcommit = {
						'commitlint',
						'gitlint',
					},
					haskell = {
						'hlint',
					},
					html = {
						'htmlhint',
						'tidy',
					},
					inko = {
						'inko',
					},
					java = {
						'checkstyle',
					},
					javascript = {
						'biomejs',
						'eslint',
						'jshint',
					},
					javascriptreact = {
						'biomejs',
					},
					json = {
						'jsonlint',
					},
					jsonc = {
						'biomejs',
					},
					kotlin = {
						'ktlint',
					},
					lua = {
						'luacheck',
					},
					markdown = {
						'biomejs',
						'markdownlint',
					},
					nix = {
						'deadnix',
						'nix',
					},
					python = {
						'bandit',
						'dmypy',
						'flake8',
						'mypy',
					},
					rust = {
						'clippy',
					},
					sh = {
						'dash',
						'shellcheck',
					},
					svelte = {
						'biomejs',
					},
					tex = {
						'chktex',
					},
					typescript = {
						'biomejs',
					},
					typescriptreact = {
						'biomejs',
					},
					vue = {
						'biomejs',
					},
					zsh = {
						'zsh',
					},
				}
				vim.api.nvim_create_autocmd(
					{
						'BufEnter',
						'BufWritePost',
						'InsertLeave',
						'TextChanged',
					},
					{
						callback = function ()
							local opt = {
								scope = 'local',
								buf = 0,
							}
							if not vim.api.nvim_get_option_value('readonly', opt) and vim.api.nvim_get_option_value('modifiable', opt) then
								lint.try_lint(nil, { ignore_errors = true })
								lint.try_lint(
									{
										'typos',
									},
									{ ignore_errors = true }
								)
							end
						end,
					}
				)
			end,
		},
	},
	-- Formatter
}
