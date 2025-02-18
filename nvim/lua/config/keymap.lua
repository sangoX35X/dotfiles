local utils = require 'utils'

vim.keymap.set('!', '<C-l>', '<Esc>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>')

-- colemak
if vim.g.colemak then
	utils.set_keymap_from_table {
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
			['e'] = 'k',
			['i'] = 'l',
			['m'] = 'i',
			['l'] = 'e',
			['N'] = 'J',
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
else
	utils.set_keymap_from_table {
		cit = {
			['<M-n>'] = { '<down>', desc = 'Back' },
			['<M-e>'] = { '<up>', desc = 'Foward' },
		},
		x = {
			['<C-h>'] = { 'gh', desc = 'Move left' },
			['<C-j>'] = { 'gj', desc = 'Move below' },
			['<C-k>'] = { 'gk', desc = 'Move above' },
			['<C-k>'] = { 'gl', desc = 'Move right' },
		},
	}
end
