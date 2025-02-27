return {
	{
		'monaqa/dial.nvim',
		keys = {
			{ '<C-a>' },
			{ '<C-x>' },
			{ 'g<C-a>' },
			{ 'g<C-x>' },
			{ mode = 'x', '<C-a>' },
			{ mode = 'x', '<C-x>' },
			{ mode = 'x', 'g<C-a>' },
			{ mode = 'x', 'g<C-x>' },
		},
		config = function ()
			local utils = require 'utils'
			local augend = require 'dial.augend'
			local config = require 'dial.config'
			local dmap = require 'dial.map'
			local set_keymap = require 'utils.keymap'.set_by_table

			---@param group? string
			---@return nil
			local function gen_keymaps (group)
				set_keymap(
					nil,
					{
						n = {
							['<C-a>'] = { dmap.inc_normal(group), buffer = true, desc = 'Increment' },
							['<C-x>'] = { dmap.dec_normal(group), buffer = true, desc = 'Decrement' },
							['g<C-a>'] = { dmap.inc_gnormal(group), buffer = true, desc = 'Increment' },
							['g<C-x>'] = { dmap.dec_gnormal(group), buffer = true, desc = 'Decrement' },
						},
						x = {
							['<C-a>'] = { dmap.inc_visual(group), buffer = true, desc = 'Increment' },
							['<C-x>'] = { dmap.dec_visual(group), buffer = true, desc = 'Decrement' },
							['g<C-a>'] = { dmap.inc_gvisual(group), buffer = true, desc = 'Increment' },
							['g<C-x>'] = { dmap.dec_gvisual(group), buffer = true, desc = 'Decrement' },
						},
					}
				)
			end

			local int = augend.integer
			local const = augend.constant
			local paren = augend.paren
			local case = augend.case
			local semver = augend.semver.alias.semver

			local common = {
				int.new { natural = false },
				int.new {
					natural = false,
					delimiter = '_',
				},
				int.alias.hex,
				int.alias.octal,
				int.alias.binary,
				augend.decimal_fraction.new { signed = true },
				augend.hexcolor.new { case = 'lower' },
				const.new { elements = { 'no', 'yes' }, preserve_case = true },
				const.new { elements = { '-', '+' } },
				const.new { elements = { '--', '++' }, word = false },
				const.new { elements = { '-=', '+=' } },
				const.new { elements = { '<', '>' } },
				const.new { elements = { '<=', '>=' } },
			}

			local c_style_eq = const.new { elements = { '!=', '==' } }
			local common_style_bool = const.alias.bool
			local python_style_bool = const.new { elements = { 'True', 'False' } }

			config.augends:register_group {
				default = common,
				lua = utils.list.marge(
					common,
					{
						paren.alias.lua_str_literal,
						case.new { types = { 'snake_case', 'camelCase', 'PascalCase' } },
						const.new { elements = { '~=', '==' } },
						common_style_bool,
					}
				rust = utils.list.marge(
					common,
					{
						paren.alias.rust_str_literal,
					}
					),
				markdown = {
					augend.misc.alias.markdown_header,
				},
				minifiles = {
					int.alias.decimal,
					case.new { types = { 'kebab-case', 'camelCase', 'PascalCase', 'SCREAMING_SNAKE_CASE' } },
				}
			}

			vim.api.nvim_create_autocmd(
				'FileType',
				{
					callback = function ()
						local group_name = nil

						if config.augends:get(vim.bo.filetype) then
							group_name = vim.bo.filetype
						end

						gen_keymaps(group_name)
					end
				}
				)

			vim.cmd.set('filetype=' .. vim.bo.filetype)
		end,
	},
}
