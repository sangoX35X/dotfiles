return {
	'echasnovski/mini.nvim',
	lazy = false,
	version = false,
	config = function ()
		---@class (exact) Keymap
		---@field key string
		---@field fun string | function
		---@field opt? table

		---@class Plugin
		---@field _disable? boolean
		---@field _key? Keymap[]
		---@field _etc? function

		---@alias MiniPluginName string

		---@type string
		local keymap_prefix = '<leader>m'

		---@param table table<MiniPluginName, Plugin>
		---@return nil
		local function load_plugins (table)
			for name, opts in pairs(table) do
				if not opts._disable then
					require('mini.' .. name).setup(opts)
					if opts._key then
						for _, keymap in ipairs(opts._key) do
							vim.keymap.set( { 'n', 'x' }, keymap_prefix .. keymap.key, keymap.fun, keymap.opt or {} )
						end
					end
					if opts._etc then
						opts._etc()
					end
				end
			end
		end

		local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]
		local footer = [[]]

		---@type table<MiniPluginName, Plugin>
		local table = {
			sessions = {
			},
			starter = {
				items = {
					require 'mini.starter'.sections.recent_files(5, true, true),
					require 'mini.starter'.sections.sessions(5, true),
					require 'mini.starter'.sections.builtin_actions(),
				},
				header = header,
				footer = footer,
			},
			basics = {
				options = {
					win_borders = 'double',
				},
				mappings = {
					windows = true,
					move_with_alt = true,
				},
				autocommands = {
					relnum_in_visual_mode = true,
				},
			}
		}
		load_plugins(table)

		local lazy_load = function ()
			---@type table<MiniPluginName, Plugin>
			local lazy_table = {
				ai = {
					n_lines = 1000,
					search_method = 'cover'
				},
				align = {
				},
				animate = {
					scroll = {
						timing = require 'mini.animate'.gen_timing.linear {
							duration = 1,
						},
					},
				},
				bracketed = {
				},
				bufremove = {
					_key = {
						{ key = 'bd', fun = require 'mini.bufremove'.delete, opt = { desc = "Delete current buffer" } },
						{ key = 'bu', fun = require 'mini.bufremove'.unshow, opt = { desc = "Unshow current buffer" } },
						{ key = 'bw', fun = require 'mini.bufremove'.wipeout, opt = { desc = "Completely delete current buffer" } },
					},
				},
				clue = {
					clues = {
						require 'mini.clue'.gen_clues.builtin_completion(),
						-- require 'mini.clue'.gen_clues.g(),
						require 'mini.clue'.gen_clues.marks(),
						require 'mini.clue'.gen_clues.registers(),
						require 'mini.clue'.gen_clues.windows(),
						require 'mini.clue'.gen_clues.z(),
					},
					triggers = {
						{ mode = 'n', keys = '<leader>' },
						{ mode = 'x', keys = '<leader>' },
						{ mode = 'n', keys = '[' },
						{ mode = 'x', keys = '[' },
						{ mode = 'n', keys = ']' },
						{ mode = 'x', keys = ']' },
						-- Built-in
						{ mode = 'i', keys = '<C-x>' },
						-- G
						{ mode = 'n', keys = 'g' },
						{ mode = 'x', keys = 'g' },
						-- Marks
						{ mode = 'n', keys = '\'' },
						{ mode = 'x', keys = '\'' },
						{ mode = 'n', keys = '`' },
						{ mode = 'x', keys = '`' },
						-- Registers
						{ mode = 'n', keys = '"' },
						{ mode = 'x', keys = '"' },
						{ mode = 'i', keys = '<C-r>' },
						{ mode = 'c', keys = '<C-r>' },
						-- Window
						{ mode = 'n', keys = '<C-w>' },
						{ mode = 'x', keys = '<C-w>' },
						-- Z
						{ mode = 'n', keys = 'z' },
						{ mode = 'x', keys = 'z' },
					},
					window = {
						delay = 300,
					},
				},
				colors = {},
				comment = {
				},
				cursorword = {
					delay = 20,
				},
				diff = {
					_key = {
						{ key = 'dt', fun = require 'mini.diff'.toggle, opt = { desc = "Toggle diff" } },
						{ key = 'dd', fun = require 'mini.diff'.toggle_overlay, opt = { desc = "Toggle diff overlay" } },
					},
					view = {
						style = 'sign',
						signs = {
							add = '┃',
							change = '┃',
							delete = '_',
						},
					},
				},
				extra = {},
				files = {
					_key = {
						{ key = 'f', fun = require 'mini.files'.open, opt = { desc = "Open mini file manager" } },
					},
					windows = {
						preview = true,
					},
				},
				git = {
					_key = {
						{ key = 'g ', fun = ":Git ", opt = { desc = "Snip of `:Git` command" } },
						{ key = 'ga', fun = ":Git add ", opt = { desc = "Snip of `:Git add` command" } },
						{ key = 'gc', fun = ":Git commit ", opt = { desc = "Snip of `:Git commit` command" } },
						{ key = 'gps', fun = ":Git push ", opt = { desc = "Snip of `:Git push` command" } },
						{ key = 'gpl', fun = ":Git pull ", opt = { desc = "Snip of `:Git pull` command" } },
						{ key = 'gh', fun = require 'mini.git'.show_range_history, opt = { desc = "Show how lines evolved" } },
						{ key = 'gd', fun = require 'mini.git'.show_diff_source, opt = { desc = "Show file state as it was at diff entry" } },
						{ key = 'gs', fun = require 'mini.git'.show_at_cursor, opt = { desc = "Shows Git related data" } },
					},
					command = {
						split = 'vertical',
					},
				},
				hipatterns = {
					highlighters = {
						fixme = { pattern = '%f[%w]()FIXME()%f[%w]', group = 'MiniHipatternsFixme' },
						hack = { pattern = '%f[%w]()HACK()%f[%w]', group = 'MiniHipatternsHack' },
						todo = { pattern = '%f[%w]()TODO()%f[%w]', group = 'MiniHipatternsTodo' },
						note = { pattern = '%f[%w]()NOTE()%f[%w]', group = 'MiniHipatternsNote' },

						hex_color = require 'mini.hipatterns'.gen_highlighter.hex_color()
					},
				},
				icons = {
				},
				indentscope = {
					_disable = true,
					deaw = {
						delay = 0,
						animation = require 'mini.indentscope'.gen_animation.none(),
					},
					options = {
						border = 'top',
						indent_at_cursor = false,
						try_as_border = true,
					},
					symbol = '┃',
				},
				jump = {
					delay = {
						highlight = 0,
					},
				},
				jump2d = {
					view = {
						dim = true,
						n_steps_ahead = 2,
					},
					allowed_windows = {
						not_current = false,
					},
				},
				map = {
					_key = {
						{ key = 'm', fun = require 'mini.map'.open, opt = { desc = "Open mini map" } },
					},
					integrations = {
						require 'mini.map'.gen_integration.diagnostic {
							error = 'DiagnosticFloatingError',
							warn  = 'DiagnosticFloatingWarn',
							info  = 'DiagnosticFloatingInfo',
							hint  = 'DiagnosticFloatingHint',
						},
					},
					symbols = {
						encode = require 'mini.map'.gen_encode_symbols.dot('4x2'),
						scroll_line = '┃▶',
						scroll_view = '┃',
					},
					window = {
						winblend = vim.api.nvim_get_option_value('winblend', {}),
						zindex = 1,
					},
				},
				misc = {
				},
				move = {
				},
				operators = {
				},
				pairs = {
				},
				pick = {
					_key = {
						{ key = 'p', fun = ":Pick ", opt = { desc = "Snip of `:Pick` command" } },
					},
				},
				splitjoin = {
					mappings = {
						split = keymap_prefix .. 'ss',
						join = keymap_prefix .. 'sj',
					},
				},
				statusline = {
				},
				surround = {
				},
				tabline = {
				},
				trailspace = {
				},
			}
			if vim.g.colemak then
				lazy_table.ai['mappings'] = {
					inside = 'A',
					inside_next = 'An',
					inside_last = 'Al',
				}
				lazy_table.files['mappings'] = {
					go_in = 'i',
					go_plus = 'I',
					mark_set = '',
				}
			end
			load_plugins(lazy_table)
		end
		vim.api.nvim_create_autocmd(
			'User',
			{
				pattern = 'VeryLazy',
				callback = lazy_load,
			}
		)
	end
}
