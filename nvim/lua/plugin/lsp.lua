return {
	{ 'b0o/schemastore.nvim' },
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'j-hui/fidget.nvim',
		},
		config = function()
			local lspconfig = require 'lspconfig'
			---@string string[]
			local laungage_server_names = {
				'clangd',
				'cssls',
				'elixirls',
				'eslint',
				'haxe-language-server',
				'html',
				'jsonls',
				'lua_ls',
				'metals',
				'tinymist',
			}

			for _, server_name in ipairs(laungage_server_names) do
				---@type boolean, table
				local ok, server_config = pcall(require, 'lsp.' .. server_name)
				if not ok then
					server_config = require 'lsp.default'
				end
				lspconfig[server_name].setup(server_config)
			end
		end,
		event = 'VeryLazy',
	},
}
