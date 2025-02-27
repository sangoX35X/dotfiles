local set_keymap = require 'utils.keymap'.set_by_table

vim.keymap.set('!', '<C-l>', '<Esc>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>')

set_keymap (
	nil,
	{
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
		is = {
			['<tab>'] = {
				function ()
					if MiniSnippets.session.get() then
						MiniSnippets.session.jump 'next'
					else
						return '<tab>'
					end
				end,
				desc = 'Jump to next snippet field',
				expr = true,
			},
			['<S-tab>'] = {
				function ()
					if MiniSnippets.session.get() then
						MiniSnippets.session.jump 'prev'
					else
						return '<S-tab>'
					end
				end,
				desc = 'Jump to prev snippet field',
				expr = true,
			}
		},
		i = {
			['<C-y>'] = {
				function ()
					if require 'copilot.suggestion'.is_visible() then
						require 'copilot.suggestion'.accept()
					elseif vim.fn['pum#visible']() then
						vim.fn['pum#map#confirm']()
					else
						return '<C-y>'
					end
				end,
				desc = 'Comfirm the ddc completion',
			},
			['<C-e>'] = {
				function ()
					if require 'copilot.suggestion'.is_visible() then
						require 'copilot.suggestion'.dismiss()
					elseif vim.fn['pum#visible']() then
						vim.schedule(vim.fn['pum#map#cancel'])
					else
						return '<C-e>'
					end
				end,
				desc = 'Cancel the ddc completion',
				expr = true,
			},
			['<C-n>'] = {
				function ()
					if require 'copilot.suggestion'.is_visible() then
						require 'copilot.suggestion'.next()
					elseif vim.fn['pum#visible']() then
						vim.fn['pum#map#insert_relative'](1, 'loop')
					elseif vim.fn['ddc#map#can_complete']() then
						vim.fn['ddc#map#manual_complete']()
					else
						return '<C-n>'
					end
				end,
				desc = 'Next ddc canditate',
			},
			['<C-p>'] = {
				function ()
					if require 'copilot.suggestion'.is_visible() then
						require 'copilot.suggestion'.prev()
					elseif vim.fn['pum#visible']() then
						vim.fn['pum#map#insert_relative'](-1, 'loop')
					elseif vim.fn['ddc#map#can_complete']() then
						vim.fn['ddc#map#manual_complete']()
					else
						return '<C-n>'
					end
				end,
				desc = 'Previous ddc canditate',
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
	}
)
-- colemak
if vim.g.colemak then
	set_keymap (
		nil,
		{
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
				['<M-e>'] = { '<up>', desc = 'Foward' },
				-- basics(move_with_alt)
				['<M-h>'] = { '<left>', desc = 'Left' },
				['<M-i>'] = { '<right>', desc = 'Right' },
			},
			it = {
				-- basics(move_with_alt)
				['<M-n>'] = { '<down>', desc = 'Down' },
				['<M-e>'] = { '<up>', desc = 'Up' },
			},
		}
	)
else
	set_keymap (
		nil,
		{
			cit = {
				['<M-n>'] = { '<down>', desc = 'Back' },
				['<M-e>'] = { '<up>', desc = 'Foward' },
			},
			x = {
				['<C-h>'] = { 'gh', desc = 'Move left' },
				['<C-j>'] = { 'gj', desc = 'Move below' },
				['<C-k>'] = { 'gk', desc = 'Move above' },
				['<C-l>'] = { 'gl', desc = 'Move right' },
			},
		}
	)
end
