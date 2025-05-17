return {
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		dependencies = {
			'j-hui/fidget.nvim',
		},
		opts = {
			{
				'biome',
				'clangd',
				'clojure_lsp',
				'haxe_language_server',
				'lua_ls',
				'nil_ls',
				'typos_lsp',
				'tinymist',
				'hls',
			},
			['*'] = {
				---@param client vim.lsp.Client
				on_attach = function (client, bufnr)
					-- Set keymaps
					local set_keymap = vim.keymap.set

					if client:supports_method('textDocument/callHierarchy', bufnr) then
						set_keymap('n', keymap_prefix.lsp .. 'lc', function ()
							vim.lsp.buf.incoming_calls()
						end, {
							buffer = bufnr,
							desc = 'List all the call sites',
						})

						set_keymap('n', keymap_prefix.lsp .. 'lC', function ()
							vim.lsp.buf.outgoing_calls()
						end, {
							buffer = bufnr,
							desc = 'List all the called items',
						})
					end

					if client:supports_method('textDocument/codeAction', bufnr) then
						set_keymap({ 'n', 'x' }, keymap_prefix.lsp .. 'a', function ()
							vim.lsp.buf.code_action()
						end, {
							buffer = bufnr,
							desc = 'Call the code actions',
						})
					end

					if client:supports_method('textDocument/declaration', bufnr) then
						set_keymap('n', 'gD', function ()
							vim.lsp.buf.declaration { reuse_win = true }
						end, {
							buffer = bufnr,
							desc = 'Jump to the declaration',
						})
					end

					if client:supports_method('textDocument/definition', bufnr) then
						set_keymap('n', 'gdd', function ()
							vim.lsp.buf.definition { reuse_win = true }
						end, {
							buffer = bufnr,
							desc = 'Jump to the definition',
						})
					end

					if client:supports_method('textDocument/hover', bufnr) then
						set_keymap('n', 'K', function ()
							vim.lsp.buf.hover { border = 'rounded' }
						end, {
							buffer = bufnr,
							desc = 'Show the hover',
						})
					end

					if client:supports_method('textDocument/implementation', bufnr) then
						set_keymap('n', keymap_prefix.lsp .. 'li', function ()
							vim.lsp.buf.implementation { reuse_win = true }
						end, {
							buffer = bufnr,
							desc = 'List all the implementations',
						})
					end

					if client:supports_method('textDocument/references', bufnr) then
						set_keymap('n', keymap_prefix.lsp .. 'lr', function ()
							vim.lsp.buf.references()
						end, {
							buffer = bufnr,
							desc = 'List all the references',
						})
					end

					if client:supports_method('textDocument/rename', bufnr) then
						set_keymap('n', keymap_prefix.lsp .. 'r', function ()
							vim.lsp.buf.rename()
						end, {
							buffer = bufnr,
							desc = 'Rename the symbol',
						})
					end

					if
						client:supports_method('textDocument/signatureHelp')
						or client:supports_method('textDocument/hover')
					then
						set_keymap('i', '<C-k>', function ()
							vim.lsp.buf.signature_help { border = 'rounded', focusable = false }
						end, {
							buffer = bufnr,
							desc = 'Show the signature help',
						})
					end

					if client:supports_method('textDocument/typeDefinition', bufnr) then
						set_keymap('n', 'gdt', function ()
							vim.lsp.buf.type_definition()
						end, {
							buffer = bufnr,
							desc = 'Jump to the definition of the type',
						})
					end

					if client:supports_method('textDocument/typeHierarchy', bufnr) then
						set_keymap('n', keymap_prefix.lsp .. 'ls', function ()
							vim.lsp.buf.typehierarchy('subtypes')
						end, {
							buffer = bufnr,
							desc = 'List all the subtypes',
						})

						set_keymap('n', keymap_prefix.lsp .. 'lS', function ()
							vim.lsp.buf.typehierarchy('supertypes')
						end, {
							buffer = bufnr,
							desc = 'List all the supertypes',
						})
					end

					-- Set options
					if client:supports_method('textDocument/codeLens', bufnr) then
						local augroup = vim.api.nvim_create_augroup('lsp.codeLens.buf_' .. bufnr, {})
						vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
							buffer = bufnr,
							group = augroup,
							desc = 'Auto refresh CodeLens',
							callback = function ()
								vim.lsp.codelens.refresh { bufnr = bufnr }
							end,
						})
						vim.lsp.codelens.refresh { bufnr = bufnr }
					end

					if client:supports_method('textDocument/foldingRange', bufnr) then
						local win = vim.api.nvim_get_current_win()
						vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
					end

					if client:supports_method('textDocument/inlayHint', bufnr) then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end

					if Snacks.git.get_root() == '' and client.root_dir then
						vim.fn.chdir(client.root_dir)
					end
				end,
			},
		},
		config = function (_, opts)
			---@type string|1
			---@type table
			for name, opts in pairs(opts) do
				if name == 1 then
					vim.lsp.enable(opts)
					goto continue
				end

				vim.lsp.config(name, opts)

				if name == '*' then
					goto continue
				end

				vim.lsp.enable(name)

				::continue::
			end
		end,
	},
	{
		'b0o/schemastore.nvim',
		ft = { 'json', 'yaml' },
		dependencies = {
			'neovim/nvim-lspconfig',
		},
		opts = function ()
			local opts = {
				jsonls = {
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = '',
							},
							schemas = require('schemastore').yaml.schemas(),
						},
					},
				},
			}
			return opts
		end,
		config = function (_, opts)
			for name, opts in pairs(opts) do
				vim.lsp.config(name, opts)
				vim.lsp.enable(name)
			end
		end,
	},
	{
		'scalameta/nvim-metals',
		ft = {
			'scala',
			'sbt',
		},
		opts = function ()
			local metals_config = require('metals').bare_config()

			metals_config.on_attach = nil

			return metals_config
		end,
		config = function (plugin, opts)
			local augroup = vim.api.nvim_create_augroup('nvim-metals', {})

			vim.api.nvim_create_autocmd('FileType', {
				pattern = plugin.ft,
				callback = function ()
					require 'metals'.initialize_or_attach(opts)
				end,
				group = augroup,
			})
		end,
	},
}
