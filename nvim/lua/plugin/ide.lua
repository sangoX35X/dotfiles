return {
	-- DAP
	{
		{
			'mfussenegger/nvim-dap',
			event = 'VeryLazy',
		},
		{
			'rcarriga/nvim-dap-ui',
			event = 'VeryLazy',
			dependencies = {
				'mfussenegger/nvim-dap',
			},
		},
	},
	-- Linter
	{
		{
			'mfussenegger/nvim-lint',
			event = 'VeryLazy',
			config = function ()
				local lint = require 'lint'
				lint.linters_by_ft = {
					c = {
						'clangtidy',
						'flawfinder',
					},
					cpp = {
						'clangtidy',
						'flawfinder',
					},
					clojure = {
						'cij-kondo',
						'joker',
					},
					cmake = {
						'cmakelint',
					},
					crystal = {
						'ameba',
					},
					css = {
						'biomejs',
						'stylelint',
					},
					elixir = {
						'credo',
					},
					fennel = {
						'fennel',
					},
					fish = {
						'fish',
					},
					gitcommit = {
						'commitlint',
						'gitlint',
					},
					haskell = {
						'hlint',
					},
					html = {
						'htmlhint',
						'tidy',
					},
					inko = {
						'inko',
					},
					java = {
						'checkstyle',
					},
					javascript = {
						'biomejs',
						'eslint',
						'jshint',
					},
					javascriptreact = {
						'biomejs',
					},
					json = {
						'jsonlint',
					},
					jsonc = {
						'biomejs',
					},
					kotlin = {
						'ktlint',
					},
					lua = {
						'luacheck',
					},
					markdown = {
						'biomejs',
						'markdownlint',
					},
					nix = {
						'deadnix',
						'nix',
					},
					python = {
						'bandit',
						'dmypy',
						'flake8',
						'mypy',
					},
					rust = {
						'clippy',
					},
					sh = {
						'dash',
						'shellcheck',
					},
					svelte = {
						'biomejs',
					},
					tex = {
						'chktex',
					},
					typescript = {
						'biomejs',
					},
					typescriptreact = {
						'biomejs',
					},
					vue = {
						'biomejs',
					},
					zsh = {
						'zsh',
					},
				}
				vim.api.nvim_create_autocmd(
					{
						'BufEnter',
						'BufWritePost',
						'InsertLeave',
						'TextChanged',
					},
					{
						callback = function ()
							local opt = {
								scope = 'local',
								buf = 0,
							}
							if not vim.api.nvim_get_option_value('readonly', opt) and vim.api.nvim_get_option_value('modifiable', opt) then
								lint.try_lint(nil, { ignore_errors = true })
								lint.try_lint(
									{
										'typos',
									},
									{ ignore_errors = true }
								)
							end
						end,
					}
				)
			end,
		},
	},
	-- Formatter
}
