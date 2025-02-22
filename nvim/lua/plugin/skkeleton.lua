return {
	'vim-skk/skkeleton',
	event = {
		{
			event = 'User',
			pattern = 'DenopsReady',
		},
	},
	keys = {
		{ mode = {'!', 't'}, '<C-j>', '<Plug>(skkeleton-toggle)' },
	},
	config = function ()
		local function callback ()
			local cache = vim.fn.stdpath('cache') .. '/skkeleton'
			if not vim.uv.fs_stat(cache) then
				vim.uv.fs_mkdir(cache, tonumber('777', 8))
			end

			local selectCanditateKeys = nil
			if vim.g.colemak then
				selectCanditateKeys = 'arstnei'
			end

			local dicts = {
				'L',
			}
			for i = #dicts, 1, -1 do
				local prefix = 'SKK-JISYO'
				local share_path = '/usr/share/skk/'
				local user_path = '~/.skk/'

				local dict = prefix .. '.' .. dicts[i]

				if vim.uv.fs_stat(share_path .. dict) then
					dict = share_path .. dict
				elseif vim.uv.fs_stat(user_path .. dict) then
					dict = user_path .. dict
				else
					table.remove(dicts, i)
				end

				dicts[i] = dict
			end

			vim.fn['skkeleton#config'] {
				completionRankFile = cache .. '/rank.json',
				databasePath = cache .. '/database.json',
				globalDictionaries = dicts,
				registerConvertResult = true,
				selectCanditateKeys = selectCanditateKeys,
				sources = {
					'skk_dictionary',
					'google_japanese_input',
				},
			}
		end
		vim.api.nvim_create_autocmd(
			'User',
			{
				pattern = 'skkeleton-initialize-pre',
				callback = callback,
			}
		)
	end,
}
