return {
	{
		'Shatur/neovim-ayu',
		lazy = false,
		opts = nil,
		config = function (_, opts)
			require('ayu').setup(opts)
			vim.cmd.colorscheme('ayu')
		end,
	},
}
