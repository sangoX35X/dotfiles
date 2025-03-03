local keymap_prefix = '<leader>s'

return {
	'folke/snacks.nvim',
	event = 'VeryLazy',
	keys = {
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'gb',
			function ()
				Snacks.git.blame_line()
			end,
			desc = 'Show git blame',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'go',
			function ()
				Snacks.gitbrowse.open()
			end,
			desc = 'Open repo in browser',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'lg',
			function ()
				Snacks.lazygit.open()
			end,
			desc = 'Open lazygit',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'll',
			function ()
				Snacks.lazygit.log()
			end,
			desc = 'Open lazygit with log',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'lf',
			function ()
				Snacks.lazygit.log_file()
			end,
			desc = 'Open lazygit with current file log',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 't',
			function ()
				Snacks.terminal.toggle()
			end,
			desc = 'Toggle terminal',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'd',
			function ()
				Snacks.toggle.dim():toggle()
			end,
			desc = 'Toggle dim mode',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'w',
			function ()
				Snacks.toggle.words():toggle()
			end,
			desc = 'Toggle auto show LSP references',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'ze',
			function ()
				Snacks.toggle.zen():toggle()
			end,
			desc = 'Toggle zen mode',
		},
		{
			mode = { 'n', 'x' },
			keymap_prefix .. 'zo',
			function ()
				Snacks.toggle.zoom():toggle()
			end,
			desc = 'Toggle zoom mode',
		},
	},
	opts = {
		dim = {
			animate = {
				enabled = false,
			},
		},
		indent = {
			indent = {
				-- hl = {
				-- 	"SnacksIndent1",
				-- 	"SnacksIndent2",
				-- 	"SnacksIndent3",
				-- 	"SnacksIndent4",
				-- 	"SnacksIndent5",
				-- 	"SnacksIndent6",
				-- 	"SnacksIndent7",
				-- 	"SnacksIndent8",
				-- },
			},
			enabled = true,
			animate = {
				enabled = false,
			},
			scope = {
				enabled = false,
			},
			chunk = {
				enabled = true,
				only_current = true,
				char = {
					corner_top = '┏',
					corner_bottom = '┗',
					horizontal = '━',
					vertical = '┃',
					arrow = '▶',
				},
			},
		},
		scope = {
			enabled = true,
		},
	},
	init = function ()
		vim.api.nvim_create_autocmd('User', {
			pattern = 'MiniFilesActionRename',
			callback = function (event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})

		local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
		vim.api.nvim_create_autocmd('User', {
			pattern = 'NvimTreeSetup',
			callback = function ()
				local events = require('nvim-tree.api').events
				events.subscribe(events.Event.NodeRenamed, function (data)
					if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
						data = data
						Snacks.rename.on_rename_file(data.old_name, data.new_name)
					end
				end)
			end,
		})
	end,
}
