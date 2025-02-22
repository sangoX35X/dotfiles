return {
	on_attach = function(client, bufnr)
		require 'utils.lsp.Setupper':new(client, bufnr):set_common()
	end,
}
