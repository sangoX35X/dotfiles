local imap_prefix = '<C-c>'

return {
	{
		'zbirenbaum/copilot.lua',
		cond = vim.fn.executable 'node' == 1,
		event = 'VeryLazy',
		opts = {
			panel = {
				auto_refresh = true,
				keymap = {
					accept = '<localleader>a',
					refresh = '<localleader>r',
					open = imap_prefix .. 'p',
				},
				layout = {
					position = 'right',
				},
			},
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = imap_prefix .. '<C-y>',
					accept_word = imap_prefix .. '<C-w>',
					accept_line = imap_prefix .. '<C-l>',
					next = imap_prefix .. '<C-n>',
					prev = imap_prefix .. '<C-p>',
					dismiss = imap_prefix .. '<C-e>',
				},
			},
			copilot_model = 'gpt-4o-copilot',
		},
		config = function (_, opts)
			local super = function ()
				return require('copilot.suggestion')
			end

			local enabled = opts.suggestion.auto_trigger
			_G.GitHubCopilot = {}
			setmetatable(GitHubCopilot, {
				__index = function (_, key)
					return super()[key]
				end,
			})

			function GitHubCopilot.is_enabled ()
				return enabled
			end
			function GitHubCopilot.toggle_auto_trigger ()
				enabled = not enabled
				super().toggle_auto_trigger()
			end
			function GitHubCopilot:enable_auto_trigger ()
				if enabled then
					return
				end
				self.toggle_auto_trigger()
			end
			function GitHubCopilot:disable_auto_trigger ()
				if not enabled then
					return
				end
				self.toggle_auto_trigger()
			end

			require('copilot').setup(opts)

			Snacks.toggle
				.new {
					name = 'GitHubCopilot',
					get = GitHubCopilot.is_enabled,
					set = function (state)
						if state then
							GitHubCopilot:enable_auto_trigger()
						else
							GitHubCopilot:disable_auto_trigger()
						end
					end,
				}
				:map(keymap_prefix.toggle .. 'c')
		end,
	},
}
