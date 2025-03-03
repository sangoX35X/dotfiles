return {
	{
		'rebelot/kanagawa.nvim',
		lazy = false,
		config = function ()
			require 'kanagawa'.setup {
				compile = true,
				undercurl = true,
				commentStyle = {
					italic = true,
					bold = false,
				},
				functionStyle = {
					italic = true,
					bold = false,
				},
				keywordStyle = {
					italic = true,
					bold = false,
				},
				statementStyle = {
					italic = false,
					bold = true,
				},
				typeStyle = {
					italic = false,
					bold = true,
				},
			}
			vim.cmd.colorscheme 'kanagawa'
		end,
	},
}
