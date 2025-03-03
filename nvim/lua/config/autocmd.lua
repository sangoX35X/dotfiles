vim.api.nvim_create_autocmd({
	'BufEnter',
	'BufWinEnter',
}, {
	pattern = {
		'*.typ',
	},
	callback = function ()
		vim.opt_local.filetype = 'typst'
	end,
})
