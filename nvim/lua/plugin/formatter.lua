return {
	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
				markdown = { 'markdownlint-cli2' },
				rust = { 'rustfmt' },
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
			'ConformInfo',
		},
		keys = {
			{
				mode = { 'n', 'x' },
				'<leader>ff',
				function ()
					require 'conform'.format {
						async = true,
					}
				end,
				desc = 'format',
			},
			{
				mode = { 'n', 'x' },
				'<leader>ft',
				function ()
					require('conform').format {
						formatters = { 'typos' },
					}
				end,
				desc = 'fix typo (typos)',
			},
		},
	},
}
