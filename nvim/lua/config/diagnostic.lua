vim.diagnostic.config {
	virtual_text = {
		---@param diagnostic vim.Diagnostic
		---@return string
		format = function (diagnostic)
			return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
		end,
	},
}
