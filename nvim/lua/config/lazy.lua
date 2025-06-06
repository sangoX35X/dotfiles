---@type string
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazy_path) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazy_path,
	}
end
vim.opt.rtp:prepend(lazy_path)

require('lazy').setup('plugin', {
	defaults = {
		lazy = true,
	},
	pkg = {
		sources = {
			'lazy',
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				'netrwPlugin',
				'matchit',
				'matchparen',
				'tutor',
			},
		},
	},
	change_detection = {
		notify = false,
	},
})
