vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.autochdir = false
vim.opt.updatetime = 100

vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,sjis,default,utf-16'

vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.tabstop = 2

vim.opt.ambiwidth = 'single'
vim.opt.cmdheight = 0
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.helplang = 'ja,en'
vim.opt.list = true
vim.opt.listchars = {
	eol = '↵',
	tab = '  ',
	space = '･',
	trail = '␣',
	extends = '➙',
}
vim.opt.number = true
vim.opt.pumblend = 15
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.winblend = 15
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.wrapscan = true

vim.opt.undofile = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.mousescroll = 'ver:1,hor:1'
vim.opt.virtualedit = 'block'

vim.g.html_no_pre = 1
vim.g.html_use_css = 1
vim.g.use_xhtml = 1

_G.keymap_prefix = {
	buffer = '<Space>b',
	buffer_wipeout = '<Space>B',
	filer = '<Space>f',
	git = '<Space>g',
	vim_info = '<Space>i',
	snacks_ff = '<Space>s',
	telescope = '<Space>t',
	translate = '<Space>T',
	format = '<Space><Space>f',
	mini = '<Space><Space>m',
	snacks = '<Space><Space>s',
	treesitter = '<Space><Space>t',
	toggle = [[\]],
	toggle_secondary = [[\\]],
}
