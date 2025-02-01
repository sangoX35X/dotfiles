vim.keymap.set('!', '<C-l>', '<Esc>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>')
vim.keymap.set('', '<S-L>', '$')
vim.keymap.set('', '<S-H>', '0')
local prefix = '<M-z>'
local map = {
	['<M-x>'] = '(',
	['<M-c>'] = '{',
	['<M-s>'] = '[',
}
for _, mode in ipairs {'i'} do
	for key, char in pairs(map) do
		vim.keymap.set(mode, prefix .. key, function () vim.api.nvim_feedkeys(char, mode, true) end, {remap = true})
	end
end
vim.keymap.set('i', '<C-c><C-x>', function () vim.feedkeys('i', '(', true) end)
