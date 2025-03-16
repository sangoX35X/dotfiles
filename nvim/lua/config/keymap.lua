local set_keymap = require 'utils.keymap'.set_by_table

local copilot_suggestion = require 'copilot.suggestion'

vim.keymap.set('!', '<C-l>', '<Esc>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>')

set_keymap(nil, {
	n = {
		['gd'] = {
			function ()
				vim.diagnostic.open_float {
					border = 'rounded',
				}
			end,
			desc = 'Show the diagnostics in a float window',
		},
	},
	i = {
		['<C-y>'] = {
			function ()
				if copilot_suggestion.is_visible() then
					copilot_suggestion.accept()
					return
				end

				if vim.fn['pum#visible']() then
					vim.schedule(vim.fn['pum#map#confirm'])
					return
				end

				return '<C-y>'
			end,
			desc = 'Accept the completion or suggestion',
			expr = true,
		},
		['<C-e>'] = {
			function ()
				if copilot_suggestion.is_visible() then
					copilot_suggestion.dismiss()
					return
				end

				if vim.fn['pum#visible']() then
					vim.schedule(vim.fn['pum#map#cancel'])
					return
				end

				return '<C-e>'
			end,
			desc = 'Dismiss the completion or suggestion',
			expr = true,
		},
		['<C-n>'] = {
			function ()
				if copilot_suggestion.is_visible() then
					copilot_suggestion.next()
				elseif vim.fn['pum#visible']() then
					vim.fn['pum#map#insert_relative'](1, 'loop')
				elseif vim.fn['ddc#map#can_complete']() then
					vim.fn['ddc#map#manual_complete']()
				else
					return '<C-n>'
				end
			end,
			desc = 'Next candidate',
		},
		['<C-p>'] = {
			function ()
				if copilot_suggestion.is_visible() then
					copilot_suggestion.prev()
				elseif vim.fn['pum#visible']() then
					vim.fn['pum#map#insert_relative'](-1, 'loop')
				elseif vim.fn['ddc#map#can_complete']() then
					vim.fn['ddc#map#manual_complete']()
				else
					return '<C-n>'
				end
			end,
			desc = 'Previous candidate',
		},
		['<C-S-n>'] = {
			function ()
				if vim.fn['pum#visible']() then
					vim.fn['pum#map#insert_relative_page'](1, 'loop')
				elseif vim.fn['ddc#map#can_complete']() then
					vim.fn['ddc#map#manual_complete']()
				else
					return '<C-S-n>'
				end
			end,
			desc = 'Next pum page',
		},
		['<C-S-p>'] = {
			function ()
				if vim.fn['pum#visible']() then
					vim.fn['pum#insert_relative_page'](-1, 'loop')
				elseif vim.fn['ddc#map#can_complete']() then
					vim.fn['ddc#map#manual_complete']()
				else
					return '<C-S-p>'
				end
			end,
			desc = 'Previous pum page',
		},
	},
})
-- colemak
if vim.g.colemak then
	set_keymap(nil, {
		n = {
			-- basics(windows)
			['<C-h>'] = { '<C-w>h', desc = 'Focus on left window' },
			['<C-n>'] = { '<C-w>j', desc = 'Focus on bottom window' },
			['<C-e>'] = { '<C-w>k', desc = 'Focus on top window' },
			['<C-i>'] = { '<C-w>l', desc = 'Focus on right window' },
			['<C-down>'] = { '"<Cmd>vertical resize -" . v:count1 . "<CR>"', desc = 'Decrease window height' },
			['<C-up>'] = { '"<Cmd>vertical resize +" . v:count1 . "<CR>"', desc = 'Increase window height' },
			['<C-left>'] = { '"<Cmd>resize -" . v:count1 . "<CR>"', desc = 'Decrease window width' },
			['<C-right>'] = { '"<Cmd>resize +" . v:count1 . "<CR>"', desc = 'Decrease window width' },
		},
		nx = {
			['n'] = 'j',
			['N'] = 'J',
			['e'] = 'k',
			['E'] = 'K',
			['i'] = 'l',
			['I'] = 'L',
			['m'] = 'i',
			['M'] = 'I',
			['l'] = 'e',
			['L'] = 'E',
			['k'] = 'n',
			['K'] = 'N',
		},
		x = {
			['<C-h>'] = { 'gh', desc = 'Move left' },
			['<C-n>'] = { 'gj', desc = 'Move below' },
			['<C-e>'] = { 'gk', desc = 'Move above' },
			['<C-i>'] = { 'gl', desc = 'Move right' },
		},
		cit = {
			['<M-n>'] = { '<down>', desc = 'Back' },
			['<M-e>'] = { '<up>', desc = 'Forward' },
			-- basics(move_with_alt)
			['<M-h>'] = { '<left>', desc = 'Left' },
			['<M-i>'] = { '<right>', desc = 'Right' },
		},
		it = {
			-- basics(move_with_alt)
			['<M-n>'] = { '<down>', desc = 'Down' },
			['<M-e>'] = { '<up>', desc = 'Up' },
		},
	})
else
	set_keymap(nil, {
		cit = {
			['<M-n>'] = { '<down>', desc = 'Back' },
			['<M-e>'] = { '<up>', desc = 'Forward' },
		},
		x = {
			['<C-h>'] = { 'gh', desc = 'Move left' },
			['<C-j>'] = { 'gj', desc = 'Move below' },
			['<C-k>'] = { 'gk', desc = 'Move above' },
			['<C-l>'] = { 'gl', desc = 'Move right' },
		},
	})
end
