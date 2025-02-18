return function (server)
	local lspconfig = require 'lspconfig'

	lspconfig[server].setup {
		on_attach = function (client, bufnr)
		end,
	}
end
