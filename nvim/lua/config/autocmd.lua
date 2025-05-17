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

vim.api.nvim_create_autocmd({
	'BufEnter',
	'BufWinEnter',
}, {
	callback = function ()
		if Snacks and vim.bo.buftype == '' then
			vim.cmd.cd(Snacks.git.get_root() or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h'))
		end
	end,
})
