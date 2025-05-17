return {
	'vim-skk/skkeleton',
	event = {
		{
			event = 'User',
			pattern = 'DenopsReady',
		},
	},
	keys = {
		{ mode = { '!', 't' }, '<C-j>', '<Plug>(skkeleton-toggle)' },
	},
	config = function ()
		local function callback ()
			local cache = vim.fn.stdpath('cache') .. '/skkeleton'
			if not vim.uv.fs_stat(cache) then
				vim.uv.fs_mkdir(cache, tonumber('777', 8))
			end

			local selectCandidateKeys = nil
			if vim.g.colemak then
				selectCandidateKeys = 'arstnei'
			end

			local dicts = {
				'L',
				'emoji',
			}
			for i = #dicts, 1, -1 do
				local prefix = 'SKK-JISYO'
				local paths = {
					'/usr/share/skk/',
					'/usr/share/skk/utf8/',
					'~/.skk/',
				}
				local share_path = '/usr/share/skk/'
				local user_path = '~/.skk/'

				local dict = prefix .. '.' .. dicts[i]

				for _, path in ipairs(paths) do
					if vim.uv.fs_stat(path .. dict) then
						dict = path .. dict
						break
					end
				end

				dicts[i] = dict
			end

			vim.fn['skkeleton#config'] {
				completionRankFile = cache .. '/rank.json',
				databasePath = cache .. '/database.json',
				globalDictionaries = dicts,
				registerConvertResult = true,
				selectCandidateKeys = selectCandidateKeys,
				sources = {
					'skk_dictionary',
					'google_japanese_input',
				},
			}
		end
		vim.api.nvim_create_autocmd('User', {
			pattern = 'skkeleton-initialize-pre',
			callback = callback,
		})
	end,
}
