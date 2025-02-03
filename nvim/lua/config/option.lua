vim.g.mapleader = ' '

vim.opt.autochdir = true

vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = "utf-8,sjis,default,utf-16"

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 0
vim.opt.expandtab = false

vim.opt.ambiwidth = "single"
vim.opt.cmdheight = 1
vim.opt.helplang = "ja,en"
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.termguicolors = true
vim.opt.pumblend = 15
vim.opt.winblend = 15
vim.opt.list = true
vim.opt.listchars = {
	eol = "↵",
	tab = "  ",
	space = "･",
	trail = "␣",
	extends = "➙"
}
vim.opt.wrap = false

vim.opt.wrapscan = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.mousescroll = 'ver:1,hor:1'
vim.opt.clipboard = "unnamedplus"
vim.opt.virtualedit = "block"

vim.g.use_xhtml = 1
vim.g.html_use_css = 1
vim.g.html_no_pre = 1
