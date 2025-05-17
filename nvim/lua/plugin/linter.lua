return {
	'mfussenegger/nvim-lint',
	event = 'VeryLazy',
	opts = {
		gitcommit = { 'commitlint' },
		markdown = { 'markdownlint-cli2' },
		rust = { 'clippy' },
		sql = { 'sqlfluff' },
	},
	config = function (_, opts)
		local lint = require 'lint'

		lint.linters_by_ft = opts

		local augroup = vim.api.nvim_create_augroup('AutoLint', {})

		vim.api.nvim_create_autocmd({
			'BufEnter',
			'BufWritePost',
			'InsertLeave',
			'TextChanged',
		}, {
			group = augroup,
			callback = function ()
				local common_opts_to_get_opt = {
					scope = 'local',
					buf = 0,
				}

				if
					vim.api.nvim_get_option_value('modifiable', common_opts_to_get_opt)
					and not vim.api.nvim_get_option_value('readonly', common_opts_to_get_opt)
				then
					lint.try_lint(nil, { ignore_errors = true })
				end
			end,
		})
	end,
}
