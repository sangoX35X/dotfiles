return {
	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				kdl = { 'kdlfmt' },
				lua = { 'stylua' },
				markdown = { 'markdownlint-cli2' },
				nix = { 'nixfmt', 'alejandra' },
				rust = { 'rustfmt' },
				sql = { lsp_format = 'never' },
				typst = { 'typstyle' },
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
				keymap_prefix.format .. 'f',
				function ()
					require 'conform'.format {
						async = true,
					}
				end,
				desc = 'format',
			},
			{
				mode = { 'n', 'x' },
				keymap_prefix.format .. 't',
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
