return {
	{
		'nvim-tree/nvim-web-devicons',
		opts = {
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
	{
		'nvim-neotest/nvim-nio',
	},
	{
		'nvim-lua/plenary.nvim',
	},
}
