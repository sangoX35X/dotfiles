vim.api.nvim_create_autocmd(
	'ColorScheme',
	{
		callback = function ()
			local hl_normal = vim.api.nvim_get_hl_by_name('Normal', true)
			vim.api.nvim_set_hl(
				0,
				'PumFloatNormal',
				{
					fg = hl_normal.fg or hl_normal.foreground
				}
			)
		end,
	}
)
