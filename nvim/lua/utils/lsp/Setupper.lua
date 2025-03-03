---@class utils.lsp.Setupper
---@field client vim.lsp.Client
---@field bufnr number
local C = {}
C.__index = C

local set_keymap = require 'utils.keymap'.set_by_table

---@param client vim.lsp.Client
---@param bufnr number
---@return utils.lsp.Setupper
function C:new(client, bufnr)
	local obj = {
		client = client,
		bufnr = bufnr,
	}
	setmetatable(obj, self)
	return obj
end

function C:set_auto_format()
	if self.client.server_capabilities.workspaceSymbolProvider then
		local augroup = vim.api.nvim_create_augroup(
			'AutoFormat' .. self.bufnr,
			{}
		)
		vim.api.nvim_create_autocmd(
			'BufWritePre',
			{
				group = augroup,
				buffer = self.bufnr,
				desc = 'Format with LS',
				callback = function()
					vim.lsp.buf.format()
				end,
			}
		)
	end
end

function C:set_auto_document_highlight()
	if self.client.server_capabilities.workspaceSymbolProvider then
		local augroup = vim.api.nvim_create_augroup(
			'LspDocumentHighlight_' .. self.bufnr,
			{}
		)
		vim.api.nvim_create_autocmd(
			{
				'CursorHold',
				'CursorHoldI',
			},
			{
				group = augroup,
				buffer = self.bufnr,
				callback = function()
					vim.lsp.buf.document_highlight()
				end,
			}
		)
		vim.api.nvim_create_autocmd(
			{
				'CursorMoved',
				'CursorMovedI',
			},
			{
				group = augroup,
				buffer = self.bufnr,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			}
		)
		vim.api.nvim_create_autocmd(
			'TextChanged',
			{
				group = augroup,
				buffer = self.bufnr,
				callback = function()
					vim.lsp.buf.clear_references()
					vim.lsp.buf.document_highlight()
				end,
			}
		)
	end
end

function C:set_common_autocmd()
	-- self:set_auto_format()
	self:set_auto_document_highlight()
end

function C:set_common_keymap()
	set_keymap(
		{
			prefix = '<localleader>',
			buffer = self.bufnr,
		},
		{
			n = {
				['jD'] = {
					function()
						vim.lsp.buf.declaration { reuse_win = true }
					end,
					desc = '[LS] Jump to the declaration of the symbol'
				},
				['jd'] = {
					function()
						vim.lsp.buf.definition { reuse_win = true }
					end,
					desc = '[LS] Jump to the definition of the symbol',
				},
				['f'] = {
					function()
						vim.lsp.buf.format()
					end,
					desc = '[LS] Format the buffer by LS',
				},
				['li'] = {
					function()
						vim.lsp.buf.implementation { reuse_win = true }
					end,
					desc = '[LS] List all the implementations for the symbol'
				},
				['lc'] = {
					function()
						vim.lsp.buf.incoming_calls()
					end,
					desc = '[LS] List all the call sites of the symbol',
				},
				['lC'] = {
					function()
						vim.lsp.buf.outgoing_calls()
					end,
					desc = '[LS] List all the items called by the symbol',
				},
				['lr'] = {
					function()
						vim.lsp.buf.references()
					end,
					desc = '[LS] List all the references to the symbol',
				},
				['r'] = {
					function()
						vim.lsp.buf.rename()
					end,
					desc = '[LS] Rename the symbol',
				},
				['s'] = {
					function()
						vim.lsp.buf.signature_help { border = 'rounded' }
					end,
					desc = '[LS] Display signature information about the symbol',
				},
				['jt'] = {
					function()
						vim.lsp.buf.type_definition()
					end,
					desc = '[LS] Jump to the definition of the type of the symbol',
				},
				['ls'] = {
					function()
						vim.lsp.buf.typehierarchy 'subtypes'
					end,
					desc = '[LS] List all the subtypes of the symbol',
				},
				['lS'] = {
					function()
						vim.lsp.buf.typehierarchy 'supertypes'
					end,
					desc = '[LS] List all the supertypes of the symbol',
				},
			},
		}
	)
	set_keymap(
		{
			buffer = self.bufnr,
		},
		{
			n = {
				['K'] = {
					function()
						vim.lsp.buf.hover { border = 'rounded' }
					end,
					desc = 'Displays hover information about the symbol',
				},
			},
		}
	)
end

function C:set_omnifunc()
	vim.api.nvim_set_option_value(
		'omnifunc',
		'v:lua.vim.lsp.omnifunc',
		{
			scope = 'local',
			buf = self.bufnr,
		}
	)
end

function C:set_common_option()
	self:set_omnifunc()
end

function C:set_common()
	self:set_common_autocmd()
	self:set_common_keymap()
	self:set_common_option()
end

return C
