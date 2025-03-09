---@type string constant
local keymap_prefix = '<leader>m'

return {
	'echasnovski/mini.nvim',
	lazy = false,
	version = false,
	---@type table<string,table|fun(table):table>
	opts = {
		ai = function (this)
			---@alias BuiltinTextobjects
			---| '"@assignment.inner"'
			---| '"@assignment.lhs"'
			---| '"@assignment.outer"'
			---| '"@assignment.rhs"'
			---| '"@attribute.inner"'
			---| '"@attribute.outer"'
			---| '"@block.inner"'
			---| '"@block.outer"'
			---| '"@call.inner"'
			---| '"@call.outer"'
			---| '"@class.inner"'
			---| '"@class.outer"'
			---| '"@comment.inner"'
			---| '"@comment.outer"'
			---| '"@conditional.inner"'
			---| '"@conditional.outer"'
			---| '"@frame.inner"' ('latex' only)
			---| '"@frame.outer"' ('latex' only)
			---| '"@function.inner"'
			---| '"@function.outer"'
			---| '"@loop.inner"'
			---| '"@loop.outer"'
			---| '"@number.inner"'
			---| '"@parameter.inner"'
			---| '"@parameter.outer"'
			---| '"@regex.inner"'
			---| '"@regex.outer"'
			---| '"@return.inner"'
			---| '"@return.outer"'
			---| '"@scopename.inner"' ('ql' only)
			---| '"@statement.outer"'
			local opts = {
				custom_textobjects = {
					-- Assignment|Attribute
					A = this.gen_spec.treesitter {
						a = {
							'@assignment.outer',
							'@attribute.outer',
						},
						i = {
							'@assignment.inner',
							'@attribute.inner',
						},
					},
					-- Block
					B = this.gen_spec.treesitter {
						a = '@block.outer',
						i = '@block.inner',
					},
					-- comment
					c = this.gen_spec.treesitter {
						a = '@comment.outer',
						i = '@comment.inner',
					},
					-- Class
					C = this.gen_spec.treesitter {
						a = '@class.outer',
						i = '@class.inner',
					},
					-- Function definition
					F = this.gen_spec.treesitter {
						a = '@function.outer',
						i = '@function.inner',
					},
					-- If
					I = this.gen_spec.treesitter {
						a = '@conditional.outer',
						i = '@conditional.inner',
					},
					-- Loop
					L = this.gen_spec.treesitter {
						a = '@loop.outer',
						i = '@loop.inner',
					},
					-- Parameter
					P = this.gen_spec.treesitter {
						a = '@loop.outer',
						i = '@loop.inner',
					},
					-- Return
					R = this.gen_spec.treesitter {
						a = '@return.outer',
						i = '@return.inner',
					},
					-- Statement
					S = this.gen_spec.treesitter {
						a = '@statement.outer',
						i = '@statement.inner',
					},
					-- Variable
					v = this.gen_spec.treesitter {
						a = '@assignment.lhs',
						i = '@assignment.rhs',
					},
					V = this.gen_spec.treesitter {
						a = '@assignment.outer',
						i = '@assignment.inner',
					},
				},
				n_lines = 2000,
				search_method = 'cover',
			}
			return opts
		end,
		align = {},
		animate = function (this)
			local opts = {
				scroll = {
					timing = this.gen_timing.quadratic {
						duration = 1,
					},
				},
			}
			return opts
		end,
		basics = function (_)
			local opts = {
				options = {
					win_borders = 'bold',
				},
				mappings = {
					windows = true,
					move_with_alt = true,
				},
				autocommands = {
					relnum_in_visual_mode = true,
				},
			}
			return opts
		end,
		bracketed = {},
		bufremove = function (this)
			local opts = {
				_keys = {
					nx = {
						bd = { this.delete, desc = 'Delete current buffer' },
						bu = { this.unshow, desc = 'Unshow current buffer' },
						bw = { this.wipeout, desc = 'Completely delete current buffer' },
					},
				},
			}
			return opts
		end,
		clue = function (this)
			local opts = {
				clues = {
					this.gen_clues.builtin_completion(),
					-- this.gen_clues.g(),
					this.gen_clues.marks(),
					this.gen_clues.registers(),
					this.gen_clues.windows(),
					this.gen_clues.z(),
				},
				triggers = {
					{ mode = 'n', keys = '<leader>' },
					{ mode = 'x', keys = '<leader>' },
					{ mode = 'n', keys = '<localleader>' },
					{ mode = 'x', keys = '<localleader>' },
					{ mode = 'n', keys = '[' },
					{ mode = 'x', keys = '[' },
					{ mode = 'n', keys = ']' },
					{ mode = 'x', keys = ']' },
					{ mode = 'x', keys = 'a' },
					{ mode = 'x', keys = 'i' },
					{ mode = 'n', keys = '\\' },
					-- Built-in
					{ mode = 'i', keys = '<C-x>' },
					-- G
					{ mode = 'n', keys = 'g' },
					{ mode = 'x', keys = 'g' },
					-- Marks
					{ mode = 'n', keys = "'" },
					{ mode = 'x', keys = "'" },
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
					config = {
						border = 'rounded',
						width = 'auto',
					},
					delay = 300,
				},
			}
			return opts
		end,
		colors = {},
		comment = {},
		cursorword = {
			delay = 20,
		},
		diff = function (this)
			local opts = {
				_keys = {
					n = {
						dd = { this.toggle, desc = 'Toggle diff' },
						['do'] = { this.toggle_overlay, desc = 'Toggle diff overlay' },
					},
				},
				view = {
					style = 'sign',
					signs = {
						add = '┃',
						change = '┃',
						delete = '_',
					},
				},
			}
			return opts
		end,
		extra = {},
		files = function (this)
			local opts = {
				_keys = {
					n = {
						f = { this.open, desc = 'Open MiniFiles' },
					},
				},
				windows = {
					preview = true,
				},
			}
			if vim.g.colemak then
				opts.mappings = {
					go_in = 'i',
					go_in_plus = 'I',
					mark_set = '',
				}
			end
			return opts
		end,
		git = function (this)
			local opts = {
				_keys = {
					nx = {
						gh = { this.show_range_history, desc = 'Show how lines evolved' },
						gd = { this.show_diff_source, desc = 'Show file state as it was at diff entry' },
						gs = { this.show_at_cursor, desc = 'Show Git related data' },
					},
				},
				command = {
					split = 'vertical',
				},
			}
			return opts
		end,
		hipatterns = function (this)
			local opts = {
				_keys = {
					n = {
						h = { this.toggle, desc = 'Toggle MiniHipatterns' },
					},
				},
				highlighters = {
					fixme = { pattern = '%f[%w]()FIXME()%f[%w]', group = 'MiniHipatternsFixme' },
					hack = { pattern = '%f[%w]()HACK()%f[%w]', group = 'MiniHipatternsHack' },
					todo = { pattern = '%f[%w]()TODO()%f[%w]', group = 'MiniHipatternsTodo' },
					note = { pattern = '%f[%w]()NOTE()%f[%w]', group = 'MiniHipatternsNote' },

					hex_color = this.gen_highlighter.hex_color(),
				},
			}
			return opts
		end,
		icons = function (this)
			local opts = {
				_before = function ()
					require 'lazy'.load {
						show = false,
						plugins = {
							'nvim-web-devicons',
						},
					}
				end,
				_after = function ()
					this.mock_nvim_web_devicons()
					vim.schedule(function ()
						this.tweak_lsp_kind 'replace'
					end)
				end,
			}
			return opts
		end,
		jump = {
			delay = {
				highlight = 0,
			},
		},
		jump2d = {
			view = {
				dim = true,
				n_steps_ahead = 1,
			},
		},
		map = function (this)
			local opts = {
				_key = {
					{ key = 'mm', fun = this.toggle, opt = { desc = 'Toggle mini map' } },
					{ key = 'mf', fun = this.toggle_focus, opt = { desc = 'Focus mini map' } },
				},
				integrations = {
					this.gen_integration.diagnostic {
						error = 'DiagnosticFloatingError',
						warn = 'DiagnosticFloatingWarn',
						info = 'DiagnosticFloatingInfo',
						hint = 'DiagnosticFloatingHint',
					},
				},
				symbols = {
					encode = this.gen_encode_symbols.dot('4x2'),
					scroll_line = '┃▶',
					scroll_view = '┃',
				},
				window = {
					winblend = vim.api.nvim_get_option_value('winblend', {}),
				},
			}
			return opts
		end,
		misc = function (this)
			local opts = {
				_keys = {
					n = {
						mz = { this.zoom, desc = 'Zoom the current buffer' },
					},
				},
			}
			return opts
		end,
		move = function (_)
			local opts = {}
			if vim.g.colemak then
				opts.mappings = {
					right = '<M-i>',
					down = '<M-n>',
					up = '<M-e>',
					line_right = '<M-i>',
					line_down = '<M-n>',
					line_up = '<M-e>',
				}
			end
			return opts
		end,
		operators = {},
		pairs = {},
		pick = {
			_keys = {
				n = {
					p = { ':Pick ', desc = 'Short-cut of `:Pick`' },
				},
			},
		},
		sessions = {},
		snippets = {},
		splitjoin = {
			mappings = {
				toggle = keymap_prefix .. 'st',
				split = keymap_prefix .. 'ss',
				join = keymap_prefix .. 'sj',
			},
			detect = {
				separator = '[,;]',
			},
		},
		starter = function (this)
			local opts = {
				items = {
					this.sections.recent_files(8, true, true),
					this.sections.sessions(4, true),
					this.sections.builtin_actions(),
				},
				header = '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗\n████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║\n██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║\n██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║\n██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║\n╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
				footer = '',
			}
			return opts
		end,
		statusline = {},
		surround = {},
		tabline = {},
		trailspace = {},
	},
	---@param opts table<string,table|fun(table):table>
	---@return nil
	config = function (_, opts)
		---@param options table<string,table|fun(table):table> a table of configurations or functions which return a configuration
		---@param name string name of plug
		---@return nil
		local function load_by_name (options, name)
			local option = options[name]
			local plug = require('mini.' .. name)
			local set_keymap = require 'utils.keymap'.set_by_table

			if type(option) == 'function' then
				option = option(plug)
			end

			local config = {}

			for key, value in pairs(option) do
				if key == '_keys' then
					set_keymap({
						prefix = keymap_prefix,
					}, value)
				elseif string.sub(key, 1, 1) == '_' then
					-- do nothing
				else
					config[key] = value
				end
			end

			if option._before then
				option._before(plug)
			end

			plug.setup(config)

			if option._after then
				option._after(plug)
			end
		end

		---@param options table<string,table|fun(table):table>
		---@param names string[]
		local function load_plugins (options, names)
			for _, name in ipairs(names) do
				load_by_name(options, name)
			end
		end

		-- startup
		load_plugins(opts, {
			'misc',
			'icons',
			'sessions',
			'starter',
		})

		-- lazy loading
		local augroup = vim.api.nvim_create_augroup('LoadMiniPlugins', {})

		vim.api.nvim_create_autocmd('User', {
			pattern = 'VeryLazy',
			group = augroup,
			callback = function ()
				load_plugins(opts, {
					'ai',
					'align',
					'animate',
					'basics',
					'bracketed',
					'bufremove',
					'clue',
					'colors',
					'comment',
					'cursorword',
					'diff',
					'extra',
					'files',
					'git',
					'hipatterns',
					'jump',
					'jump2d',
					'map',
					'move',
					'operators',
					'pick',
					'snippets',
					'splitjoin',
					'statusline',
					'surround',
					'tabline',
					'trailspace',
				})
			end,
		})

		vim.api.nvim_create_autocmd('InsertEnter', {
			group = augroup,
			callback = function ()
				load_plugins(opts, {
					'pairs',
				})
			end,
		})
	end,
}
