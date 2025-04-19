return {
	{ 'b0o/schemastore.nvim' },
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'j-hui/fidget.nvim',
		},
		opts = function (_)
			local Setupper = require 'utils.lsp.Setupper'
			local opts = {
				clangd = true,
				cssls = true,
				elixirls = true,
				eslint = true,
				haxe_language_server = true,
				html = true,
				jsonls = {
					on_attach = function (client, bufnr)
						Setupper:new(client, bufnr):set_common()
					end,
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = { enable = true },
						},
					},
				},
				lua_ls = true,
				rust_analyzer = true,
				tinymist = true,
				typos_lsp = {},
				yamlls = {
					on_attach = function (client, bufnr)
						Setupper:new(client, bufnr):set_common()
					end,
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
			local lspconfig = require 'lspconfig'
			local utils = require 'utils'

			local function get_server_config_rec (server_name)
				local server_config_or_name = opts[server_name]

				local default_config = {
					on_attach = function (client, bufnr)
						utils.lsp.Setupper:new(client, bufnr):set_common()
					end,
					capabilities = require('cmp_nvim_lsp').default_capabilities(),
				}

				if type(server_config_or_name) == 'table' then
					return server_config_or_name
				end

				if server_config_or_name == true then
					return default_config
				end

				if type(server_config_or_name) == 'string' then
					return get_server_config_rec(server_config_or_name)
				end

				local error_message = ('Unexpected value was found in %s(LS): %s'):format(
					server_name,
					server_config_or_name
				)
				vim.notify(error_message)

				return default_config
			end

			for server_name, _ in pairs(opts) do
				local server = lspconfig[server_name]
				local server_config = get_server_config_rec(server_name)
				local cmd = utils.table.get_nested(server_config, 'cmd', 1)
					or utils.table.get_nested(server, 'config_def', 'default_config', 'cmd', 1)

				-- コマンドが実行可能な場合にのみ設定を行う
				if cmd and vim.fn.executable(cmd) == 1 then
					server.setup(server_config)
				end
			end
		end,
		event = 'VeryLazy',
	},
	{
		'scalameta/nvim-metals',
		ft = {
			'scala',
			'sbt',
		},
		opts = function ()
			local metals_config = require 'metals'.bare_config()

			metals_config.on_attach = function (client, bufnr)
				require 'utils.lsp.Setupper':new(client, bufnr):set_common()
			end

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
