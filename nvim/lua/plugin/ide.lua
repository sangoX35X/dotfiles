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
				lint.linters_by_ft = {}
				vim.api.nvim_create_autocmd({
					'BufEnter',
					'BufWritePost',
					'InsertLeave',
					'TextChanged',
				}, {
					callback = function ()
						local opt = {
							scope = 'local',
							buf = 0,
						}
						if
							not vim.api.nvim_get_option_value('readonly', opt)
							and vim.api.nvim_get_option_value('modifiable', opt)
						then
							lint.try_lint(nil, { ignore_errors = true })
							lint.try_lint({
								'typos',
							}, { ignore_errors = true })
						end
					end,
				})
			end,
		},
	},
}
