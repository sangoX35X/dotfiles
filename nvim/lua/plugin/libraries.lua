return {
	{
		'nvim-tree/nvim-web-devicons',
		opt = {
		},
	},
	{
		'vim-denops/denops.vim',
		event = 'VeryLazy',
		config = function ()
			-- start
			vim.fn['denops#server#start']()
		end,
	},
}
