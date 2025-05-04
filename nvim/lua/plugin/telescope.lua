local keymap_prefix = '<leader><leader>t'

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	cmd = { 'Telescope' },
	keys = {
		{
			desc = ':Telescope',
			mode = { 'n', 'x' },
			keymap_prefix .. '<space>',
			':Telescope ',
		},
		{
			desc = 'Telescope current buffer fuzzy find',
			mode = { 'n', 'x' },
			keymap_prefix .. 'a',
			function ()
				require('telescope.builtin').current_buffer_fuzzy_find()
			end,
		},
		{
			desc = 'Telescope buffers',
			mode = { 'n', 'x' },
			keymap_prefix .. 'b',
			function ()
				require('telescope.builtin').buffers()
			end,
		},
		{
			desc = 'Telescope oldfiles',
			mode = { 'n', 'x' },
			keymap_prefix .. 'B',
			function ()
				require('telescope.builtin').oldfiles()
			end,
		},
		{
			desc = 'Telescope commands',
			mode = { 'n', 'x' },
			keymap_prefix .. 'c',
			function ()
				require('telescope.builtin').commands()
			end,
		},
		{
			desc = 'Telescope command history',
			mode = { 'n', 'x' },
			keymap_prefix .. 'C',
			function ()
				require('telescope.builtin').command_history()
			end,
		},
		{
			desc = 'Telescope diagnostics',
			mode = { 'n', 'x' },
			keymap_prefix .. 'd',
			function ()
				require('telescope.builtin').diagnostics()
			end,
		},
		{
			desc = 'Telescope find files',
			mode = { 'n', 'x' },
			keymap_prefix .. 'f',
			function ()
				require('telescope.builtin').find_files()
			end,
		},
		{
			desc = 'Telescope git files',
			mode = { 'n', 'x' },
			keymap_prefix .. 'F',
			function ()
				require('telescope.builtin').git_files()
			end,
		},
		{
			desc = 'Telescope grep string',
			mode = { 'n', 'x' },
			keymap_prefix .. 'g',
			function ()
				require('telescope.builtin').grep_string()
			end,
		},
		{
			desc = 'Telescope live grep',
			mode = { 'n', 'x' },
			keymap_prefix .. 'G',
			function ()
				require('telescope.builtin').live_grep()
			end,
		},
		{
			desc = 'Telescope help tags',
			mode = { 'n', 'x' },
			keymap_prefix .. 'h',
			function ()
				require('telescope.builtin').help_tags()
			end,
		},
		{
			desc = 'Telescope jump list',
			mode = { 'n', 'x' },
			keymap_prefix .. 'j',
			function ()
				require('telescope.builtin').jumplist()
			end,
		},
		{
			desc = 'Telescope keymaps',
			mode = { 'n', 'x' },
			keymap_prefix .. 'k',
			function ()
				require('telescope.builtin').keymaps()
			end,
		},
		{
			desc = 'Telescope lsp references',
			mode = { 'n', 'x' },
			keymap_prefix .. 'lr',
			function ()
				require('telescope.builtin').lsp_references()
			end,
		},
		{
			desc = 'Telescope lsp incoming calls',
			mode = { 'n', 'x' },
			keymap_prefix .. 'lc',
			function ()
				require('telescope.builtin').lsp_incoming_calls()
			end,
		},
		{
			desc = 'Telescope lsp outgoing calls',
			mode = { 'n', 'x' },
			keymap_prefix .. 'lC',
			function ()
				require('telescope.builtin').lsp_outgoing_calls()
			end,
		},
		{
			desc = 'Telescope lsp document symbols',
			mode = { 'n', 'x' },
			keymap_prefix .. 'ld',
			function ()
				require('telescope.builtin').lsp_document_symbols()
			end,
		},
		{
			desc = 'Telescope lsp workdspace symbols',
			mode = { 'n', 'x' },
			keymap_prefix .. 'lw',
			function ()
				require('telescope.builtin').lsp_workspace_symbols()
			end,
		},
		{
			desc = 'Telescope lsp dynamic workdspace symbols',
			mode = { 'n', 'x' },
			keymap_prefix .. 'lW',
			function ()
				require('telescope.builtin').lsp_dynamic_workspace_symbols()
			end,
		},
		{
			desc = 'Telescope lsp implementations',
			mode = { 'n', 'x' },
			keymap_prefix .. 'li',
			function ()
				require('telescope.builtin').lsp_implementations()
			end,
		},
		{
			desc = 'Telescope lsp definitions',
			mode = { 'n', 'x' },
			keymap_prefix .. 'ld',
			function ()
				require('telescope.builtin').lsp_definitions()
			end,
		},
		{
			desc = 'Telescope lsp type definitions',
			mode = { 'n', 'x' },
			keymap_prefix .. 'lD',
			function ()
				require('telescope.builtin').lsp_type_definitions()
			end,
		},
		{
			desc = 'Telescope marks',
			mode = { 'n', 'x' },
			keymap_prefix .. 'm',
			function ()
				require('telescope.builtin').marks()
			end,
		},
		{
			desc = 'Telescope pickers',
			mode = { 'n', 'x' },
			keymap_prefix .. 'p',
			function ()
				require('telescope.builtin').pickers()
			end,
		},
		{
			desc = 'Telescope resume',
			mode = { 'n', 'x' },
			keymap_prefix .. 'P',
			function ()
				require('telescope.builtin').resume()
			end,
		},
		{
			desc = 'Telescope quickfix',
			mode = { 'n', 'x' },
			keymap_prefix .. 'q',
			function ()
				require('telescope.builtin').quickfix()
			end,
		},
		{
			desc = 'Telescope quickfix history',
			mode = { 'n', 'x' },
			keymap_prefix .. 'Q',
			function ()
				require('telescope.builtin').quickfixhistory()
			end,
		},
		{
			desc = 'Telescope builtin',
			mode = { 'n', 'x' },
			keymap_prefix .. 't',
			function ()
				require('telescope.builtin').builtin()
			end,
		},
		{
			desc = 'Telescope treesitter',
			mode = { 'n', 'x' },
			keymap_prefix .. 'T',
			function ()
				require('telescope.builtin').treesitter()
			end,
		},
		{
			desc = 'Telescope git branches',
			mode = { 'n', 'x' },
			keymap_prefix .. 'xb',
			function ()
				require('telescope.builtin').git_branches()
			end,
		},
		{
			desc = 'Telescope git commits',
			mode = { 'n', 'x' },
			keymap_prefix .. 'xc',
			function ()
				require('telescope.builtin').git_commits()
			end,
		},
		{
			desc = 'Telescope git bcommits',
			mode = { 'n' },
			keymap_prefix .. 'xC',
			function ()
				require('telescope.builtin').git_bcommits()
			end,
		},
		{
			desc = 'Telescope git bcommits (range)',
			mode = { 'x' },
			keymap_prefix .. 'xC',
			function ()
				require('telescope.builtin').git_bcommits_range()
			end,
		},
		{
			desc = 'Telescope git stash',
			mode = { 'n', 'x' },
			keymap_prefix .. 'xs',
			function ()
				require('telescope.builtin').git_stash()
			end,
		},
		{
			desc = 'Telescope git status',
			mode = { 'n', 'x' },
			keymap_prefix .. 'xv',
			function ()
				require('telescope.builtin').git_status()
			end,
		},
	},
}
