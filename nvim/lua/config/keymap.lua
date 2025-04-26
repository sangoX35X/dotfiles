local set_keymap = require 'utils.keymap'.set_by_table

vim.keymap.set('!', '<C-l>', '<Esc>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>')

set_keymap(nil, {
	nx = {
		['<C-i>'] = {
			function ()
				vim.diagnostic.open_float {
					border = 'rounded',
				}
			end,
			desc = 'Show the diagnostics in a float window',
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
