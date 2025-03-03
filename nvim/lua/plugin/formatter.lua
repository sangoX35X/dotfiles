return {
	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
			},
			format_on_save = {},
			default_format_opts = {
				lsp_format = 'fallback',
				stop_after_first = true,
			},
		},
		event = {
			'BufWritePre',
		},
		cmd = {
			'ComformInfo',
		},
		keys = {
			{
				mode = {
					'n',
					'x',
				},
				'<leader>f',
				function ()
					require 'conform'.format {
						async = true,
					}
				end,
			},
		},
	},
}
