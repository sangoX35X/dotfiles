local M = {}

M[1] = 'folke/snacks.nvim'
M.lazy = false

M.keys = {
	-- bufdelete
	{
		desc = 'Delete current buffer',
		keymap_prefix.buffer .. 'b',
		function ()
			Snacks.bufdelete { buf = 0, force = false, wipe = false }
		end,
	},
	{
		desc = 'Delete buffers except current',
		keymap_prefix.buffer .. 'B',
		function ()
			local current = vim.api.nvim_get_current_buf()
			Snacks.bufdelete {
				buf = 0,
				force = false,
				wipe = false,
				filter = function (bufnr)
					return bufnr ~= current
				end,
			}
		end,
	},
	{
		desc = 'Wipeout current buffer',
		keymap_prefix.buffer_wipeout .. 'b',
		function ()
			Snacks.bufdelete { buf = 0, force = true, wipe = true }
		end,
	},
	{
		desc = 'Wipeout buffers except current',
		keymap_prefix.buffer_wipeout .. 'B',
		function ()
			local current = vim.api.nvim_get_current_buf()
			Snacks.bufdelete {
				buf = 0,
				force = true,
				wipe = true,
				filter = function (bufnr)
					return bufnr ~= current
				end,
			}
		end,
	},
	-- explorer
	{
		desc = "Open Snacks' filer",
		keymap_prefix.filer .. 's',
		function ()
			Snacks.explorer.reveal()
		end,
	},
	-- git
	{
		desc = 'Show git blame',
		keymap_prefix.git .. 'b',
		function ()
			Snacks.git.blame_line()
		end,
	},
	-- gitbrowse
	{
		desc = 'Open git file in browser',
		mode = { 'n', 'x' },
		keymap_prefix.git .. 'x',
		function ()
			Snacks.gitbrowse.open { what = 'file' }
		end,
	},
	{
		desc = 'Open git repo in browser',
		keymap_prefix.git .. 'X',
		function ()
			Snacks.gitbrowse.open { what = 'repo' }
		end,
	},
	-- lazygit
	{
		desc = 'Open lazygit',
		keymap_prefix.git .. 'L',
		function ()
			Snacks.lazygit.open()
		end,
	},
	{
		desc = 'Open log with lazygit',
		keymap_prefix.git .. 'll',
		function ()
			Snacks.lazygit.log()
		end,
	},
	{
		desc = 'Open current file log with lazygit',
		keymap_prefix.git .. 'lL',
		function ()
			Snacks.lazygit.log_file()
		end,
	},
	-- notifier
	{
		desc = 'Show notifier history',
		keymap_prefix.vim_info .. 'n',
		function ()
			Snacks.notifier.show_history()
		end,
	},
	-- picker
	--   Top Pickers & Explorer
	{
		keymap_prefix.snacks_ff .. '<space>',
		function ()
			Snacks.picker.smart()
		end,
		desc = 'Smart Find Files',
	},
	{
		keymap_prefix.snacks_ff .. ',',
		function ()
			Snacks.picker.buffers()
		end,
		desc = 'Buffers',
	},
	{
		keymap_prefix.snacks_ff .. '/',
		function ()
			Snacks.picker.grep()
		end,
		desc = 'Grep',
	},
	{
		keymap_prefix.snacks_ff .. ':',
		function ()
			Snacks.picker.command_history()
		end,
		desc = 'Command History',
	},
	{
		keymap_prefix.snacks_ff .. 'n',
		function ()
			Snacks.picker.notifications()
		end,
		desc = 'Notification History',
	},
	{
		keymap_prefix.snacks_ff .. 'e',
		function ()
			Snacks.explorer()
		end,
		desc = 'File Explorer',
	},
	--   find
	{
		keymap_prefix.snacks_ff .. 'fb',
		function ()
			Snacks.picker.buffers()
		end,
		desc = 'Buffers',
	},
	{
		keymap_prefix.snacks_ff .. 'fc',
		function ()
			Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
		end,
		desc = 'Find Config File',
	},
	{
		keymap_prefix.snacks_ff .. 'ff',
		function ()
			Snacks.picker.files()
		end,
		desc = 'Find Files',
	},
	{
		keymap_prefix.snacks_ff .. 'fg',
		function ()
			Snacks.picker.git_files()
		end,
		desc = 'Find Git Files',
	},
	{
		keymap_prefix.snacks_ff .. 'fp',
		function ()
			Snacks.picker.projects()
		end,
		desc = 'Projects',
	},
	{
		keymap_prefix.snacks_ff .. 'fr',
		function ()
			Snacks.picker.recent()
		end,
		desc = 'Recent',
	},
	--   git
	{
		keymap_prefix.snacks_ff .. 'gb',
		function ()
			Snacks.picker.git_branches()
		end,
		desc = 'Git Branches',
	},
	{
		keymap_prefix.snacks_ff .. 'gl',
		function ()
			Snacks.picker.git_log()
		end,
		desc = 'Git Log',
	},
	{
		keymap_prefix.snacks_ff .. 'gL',
		function ()
			Snacks.picker.git_log_line()
		end,
		desc = 'Git Log Line',
	},
	{
		keymap_prefix.snacks_ff .. 'gs',
		function ()
			Snacks.picker.git_status()
		end,
		desc = 'Git Status',
	},
	{
		keymap_prefix.snacks_ff .. 'gS',
		function ()
			Snacks.picker.git_stash()
		end,
		desc = 'Git Stash',
	},
	{
		keymap_prefix.snacks_ff .. 'gd',
		function ()
			Snacks.picker.git_diff()
		end,
		desc = 'Git Diff (Hunks)',
	},
	{
		keymap_prefix.snacks_ff .. 'gf',
		function ()
			Snacks.picker.git_log_file()
		end,
		desc = 'Git Log File',
	},
	--   Grep
	{
		keymap_prefix.snacks_ff .. 'sb',
		function ()
			Snacks.picker.lines()
		end,
		desc = 'Buffer Lines',
	},
	{
		keymap_prefix.snacks_ff .. 'sB',
		function ()
			Snacks.picker.grep_buffers()
		end,
		desc = 'Grep Open Buffers',
	},
	{
		keymap_prefix.snacks_ff .. 'sg',
		function ()
			Snacks.picker.grep()
		end,
		desc = 'Grep',
	},
	{
		keymap_prefix.snacks_ff .. 'sw',
		function ()
			Snacks.picker.grep_word()
		end,
		desc = 'Visual selection or word',
		mode = { 'n', 'x' },
	},
	--   search
	{
		keymap_prefix.snacks_ff .. 's"',
		function ()
			Snacks.picker.registers()
		end,
		desc = 'Registers',
	},
	{
		keymap_prefix.snacks_ff .. 's/',
		function ()
			Snacks.picker.search_history()
		end,
		desc = 'Search History',
	},
	{
		keymap_prefix.snacks_ff .. 'sa',
		function ()
			Snacks.picker.autocmds()
		end,
		desc = 'Autocmds',
	},
	{
		keymap_prefix.snacks_ff .. 'sb',
		function ()
			Snacks.picker.lines()
		end,
		desc = 'Buffer Lines',
	},
	{
		keymap_prefix.snacks_ff .. 'sc',
		function ()
			Snacks.picker.command_history()
		end,
		desc = 'Command History',
	},
	{
		keymap_prefix.snacks_ff .. 'sC',
		function ()
			Snacks.picker.commands()
		end,
		desc = 'Commands',
	},
	{
		keymap_prefix.snacks_ff .. 'sd',
		function ()
			Snacks.picker.diagnostics()
		end,
		desc = 'Diagnostics',
	},
	{
		keymap_prefix.snacks_ff .. 'sD',
		function ()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = 'Buffer Diagnostics',
	},
	{
		keymap_prefix.snacks_ff .. 'sh',
		function ()
			Snacks.picker.help()
		end,
		desc = 'Help Pages',
	},
	{
		keymap_prefix.snacks_ff .. 'sH',
		function ()
			Snacks.picker.highlights()
		end,
		desc = 'Highlights',
	},
	{
		keymap_prefix.snacks_ff .. 'si',
		function ()
			Snacks.picker.icons()
		end,
		desc = 'Icons',
	},
	{
		keymap_prefix.snacks_ff .. 'sj',
		function ()
			Snacks.picker.jumps()
		end,
		desc = 'Jumps',
	},
	{
		keymap_prefix.snacks_ff .. 'sk',
		function ()
			Snacks.picker.keymaps()
		end,
		desc = 'Keymaps',
	},
	{
		keymap_prefix.snacks_ff .. 'sl',
		function ()
			Snacks.picker.loclist()
		end,
		desc = 'Location List',
	},
	{
		keymap_prefix.snacks_ff .. 'sm',
		function ()
			Snacks.picker.marks()
		end,
		desc = 'Marks',
	},
	{
		keymap_prefix.snacks_ff .. 'sM',
		function ()
			Snacks.picker.man()
		end,
		desc = 'Man Pages',
	},
	{
		keymap_prefix.snacks_ff .. 'sp',
		function ()
			Snacks.picker.lazy()
		end,
		desc = 'Search for Plugin Spec',
	},
	{
		keymap_prefix.snacks_ff .. 'sq',
		function ()
			Snacks.picker.qflist()
		end,
		desc = 'Quickfix List',
	},
	{
		keymap_prefix.snacks_ff .. 'sR',
		function ()
			Snacks.picker.resume()
		end,
		desc = 'Resume',
	},
	{
		keymap_prefix.snacks_ff .. 'su',
		function ()
			Snacks.picker.undo()
		end,
		desc = 'Undo History',
	},
	{
		keymap_prefix.snacks_ff .. 'uC',
		function ()
			Snacks.picker.colorschemes()
		end,
		desc = 'Colorschemes',
	},
	--   LSP
	{
		keymap_prefix.snacks_ff .. 'ld',
		function ()
			Snacks.picker.lsp_definitions()
		end,
		desc = 'Goto Definition',
	},
	{
		keymap_prefix.snacks_ff .. 'lD',
		function ()
			Snacks.picker.lsp_declarations()
		end,
		desc = 'Goto Declaration',
	},
	{
		keymap_prefix.snacks_ff .. 'lr',
		function ()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = 'References',
	},
	{
		keymap_prefix.snacks_ff .. 'lI',
		function ()
			Snacks.picker.lsp_implementations()
		end,
		desc = 'Goto Implementation',
	},
	{
		keymap_prefix.snacks_ff .. 'ly',
		function ()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = 'Goto T[y]pe Definition',
	},
	{
		keymap_prefix.snacks_ff .. 'ss',
		function ()
			Snacks.picker.lsp_symbols()
		end,
		desc = 'LSP Symbols',
	},
	{
		keymap_prefix.snacks_ff .. 'sS',
		function ()
			Snacks.picker.lsp_workspace_symbols()
		end,
		desc = 'LSP Workspace Symbols',
	},
	-- scratch
	{
		desc = 'Toggle Scratch Buffer',
		keymap_prefix.snacks .. 's',
		function ()
			Snacks.scratch()
		end,
	},
	{
		desc = 'Select Scratch Buffer',
		keymap_prefix.snacks .. 'S',
		function ()
			Snacks.scratch.select()
		end,
	},
	{
		desc = 'Toggle terminal',
		keymap_prefix.snacks .. 't',
		function ()
			Snacks.terminal.toggle()
		end,
	},
}
M.opts = {}
M.opts.bigfile = {
	enabled = true,
	notify = true,
}
M.opts.dashboard = {
	enabled = true,
	sections = {
		function ()
			local result = {}
			result.padding = 2

			if vim.fn.executable('tte') == 1 then
				local header = [[
'███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝']]
				local subcommands = {
					'beams',
					'binarypath',
					'blackhole',
					'bouncyballs',
					'bubbles',
					'burn',
					'colorshift',
					'crumble',
					'decrypt',
					'errorcorrect',
					'expand',
					'fireworks',
					'highlight',
					'laseretch',
					'matrix',
					'middleout',
					'orbittingvolley',
					'overflow',
					'pour',
					'print',
					'rain',
					'randomsequence',
					'rings',
					'scattered',
					'slice',
					'slide',
					'spotlights',
					'spray',
					'swarm',
					'sweep',
					'synthgrid',
					'unstable',
					'vhstape',
					'waves',
					'wipe',
				}
				local subcommand = subcommands[math.random(#subcommands)]
				local cmd = ('echo %s | tte --anchor-canvas s %s'):format(header, subcommand)
				result.section = 'terminal'
				result.cmd = cmd
				result.height = 6
			else
				result.section = 'header'
			end

			return result
		end,
		{
			section = 'keys',
			gap = 1,
			padding = 2,
		},
		{
			pane = 2,
			{
				section = 'recent_files',
				icon = ' ',
				title = 'Recent Files',
				indent = 2,
				padding = 2,
				cwd = true,
			},
			{
				section = 'projects',
				icon = ' ',
				title = 'Projects',
				indent = 2,
				padding = 2,
			},
			{
				section = 'session',
				icon = ' ',
				title = 'Sessions',
				indent = 2,
				padding = 2,
			},
		},
		{
			section = 'startup',
		},
	},
}
M.opts.dim = {
	animate = {
		enabled = true,
		duration = {
			total = 100,
		},
		easing = 'inOutQuad',
	},
}
M.opts.explorer = {
	replace_netew = false,
}
M.opts.indent = {
	enabled = true,
	indent = {
		enabled = true,
	},
	animate = {
		enabled = true,
		style = 'down',
		easing = 'linear',
		duration = {
			total = 100,
		},
	},
	scope = {
		enabled = true,
		char = '╎',
		only_current = true,
	},
	chunk = {
		enabled = true,
		only_current = true,
		char = {
			corner_top = '╭',
			corner_bottom = '╰',
			horizontal = '─',
			vertical = '│',
			arrow = '▶',
		},
	},
}
M.opts.input = {
	enabled = true,
}
M.opts.quickfile = {
	enabled = true,
}
M.opts.scope = {
	enabled = true,
	treesitter = {
		blocks = {
			enabled = true,
		},
	},
	keys = {
		textobject = {
			ii = {
				treesitter = {
					blocks = {
						enabled = true,
					},
				},
			},
			ai = {
				treesitter = {
					blocks = {
						enabled = true,
					},
				},
			},
		},
	},
	jump = {
		['[i'] = {
			treesitter = {
				blocks = {
					enabled = true,
				},
			},
		},
		[']i'] = {
			treesitter = {
				blocks = {
					enabled = true,
				},
			},
		},
	},
}
M.opts.scroll = {
	enabled = true,
	animate = {
		easing = 'inOutQuad',
		duration = {
			total = 100,
		},
	},
	animate_repeat = {
		easing = 'linear',
		duration = {
			total = 20,
		},
	},
}
M.opts.styles = {
	blame_line = {
		width = 0.8,
		height = 0.8,
	},
	input = {
		relative = 'cursor',
	},
	notification_history = {
		width = 0.8,
		height = 0.8,
	},
}
M.opts.notifier = {
	enabled = true,
	width = { min = 0.1, max = 0.2 },
	height = { min = 1, max = 0.6 },
	style = 'fancy',
}
M.opts.words = {
	enabled = true,
}

M.config = function (_, opts)
	require('snacks').setup(opts)

	-- rename
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

	-- picker
	vim.ui.select = function (...)
		Snacks.picker.select(...)
	end

	-- toggle
	Snacks.toggle.animate():map(keymap_prefix.toggle .. 'a')
	Snacks.toggle
		.option('cursorline', { on = true, off = false, global = false })
		:map(keymap_prefix.toggle_secondary .. 'c')
	Snacks.toggle
		.option('cursorcolumn', { on = true, off = false, global = false })
		:map(keymap_prefix.toggle_secondary .. 'C')
	Snacks.toggle.diagnostics():map(keymap_prefix.toggle_secondary .. 'd')
	Snacks.toggle.dim():map(keymap_prefix.toggle .. 'D')
	Snacks.toggle.option('expandtab', { on = true, off = false, global = false }):map(keymap_prefix.toggle .. 'e')
	Snacks.toggle.option('hlsearch', { on = true, off = false, global = true }):map(keymap_prefix.toggle .. 'h')
	Snacks.toggle.inlay_hints():map(keymap_prefix.toggle .. 'i')
	Snacks.toggle.indent():map(keymap_prefix.toggle .. 'I')
	Snacks.toggle
		.option('ignorecase', { on = true, off = false, global = true })
		:map(keymap_prefix.toggle_secondary .. 'i')
	Snacks.toggle.option('list', { on = true, off = false, global = false }):map(keymap_prefix.toggle .. 'l')
	Snacks.toggle.line_number():map(keymap_prefix.toggle .. 'n')
	Snacks.toggle.option('relativenumber', { on = true, off = false, global = false }):map(keymap_prefix.toggle .. 'N')
	Snacks.toggle.profiler():map(keymap_prefix.toggle .. 'p')
	Snacks.toggle.profiler_highlights():map(keymap_prefix.toggle .. 'P')
	Snacks.toggle.option('signcolumn', { on = 'yes', off = 'no', global = false }):map(keymap_prefix.toggle .. 's')
	Snacks.toggle.treesitter():map(keymap_prefix.toggle .. 't')
	Snacks.toggle.option('wrap', { on = true, off = false, global = false }):map(keymap_prefix.toggle .. 'w')
	Snacks.toggle.words():map(keymap_prefix.toggle .. 'W')
	Snacks.toggle.zen():map(keymap_prefix.toggle .. 'z')
	Snacks.toggle.zoom():map(keymap_prefix.toggle .. 'Z')
end

return M
