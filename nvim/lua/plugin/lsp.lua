return {
	{ 'b0o/schemastore.nvim' },
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'j-hui/fidget.nvim',
		},
		config = function()
			local lspconfig = require 'lspconfig'
			local utils = require 'utils'
			---@string string[]
			local laungage_server_names = {
				'clangd',
				'cssls',
				'elixirls',
				'eslint',
				'haxe_language_server',
				'html',
				'jsonls',
				'lua_ls',
				'metals',
				'tinymist',
			}

			for _, server_name in ipairs(laungage_server_names) do
				-- <server_name>.lua が存在しない場合は default.lua を使用する
				---@type boolean, table
				local ok, server_config = pcall(require, 'lsp.' .. server_name)
				if not ok then
					server_config = require 'lsp.default'
				end

				-- コマンドが実行可能な場合にのみ設定を行う
				local server = lspconfig[server_name]
				local lsp_cmd =
					utils.table.get_nested(server_config, 'cmd', 1)
					or utils.table.get_nested(server, 'config_def', 'default_config', 'cmd', 1)

				if lsp_cmd and vim.fn.executable(lsp_cmd) == 1 then
					server.setup(server_config)
				end
			end
		end,
		event = 'VeryLazy',
	},
}
