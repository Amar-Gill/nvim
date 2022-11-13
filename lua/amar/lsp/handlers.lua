local nnoremap = require("amar.keymap").nnoremap

local M = {}

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
		timeout_ms = 5000,
	})
end

local display_lsp_signature = function(bufnr)
	local status, lsp_signature = pcall(require, "lsp_signature")
	if not status then
		return
	end

	lsp_signature.on_attach({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
end

local lsp_keymaps = function(bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	nnoremap("gD", vim.lsp.buf.declaration, bufopts)
	nnoremap("gd", vim.lsp.buf.definition, bufopts)
	nnoremap("K", vim.lsp.buf.hover, bufopts)
	nnoremap("gi", vim.lsp.buf.implementation, bufopts)
	nnoremap("gs", vim.lsp.buf.signature_help, bufopts)
	nnoremap("<leader>D", vim.lsp.buf.type_definition, bufopts)
	nnoremap("<leader>rn", vim.lsp.buf.rename, bufopts)
	nnoremap("<leader>ca", vim.lsp.buf.code_action, bufopts)
	nnoremap("gr", vim.lsp.buf.references, bufopts)
	nnoremap("<leader>f", function()
		lsp_formatting(bufnr)
	end, bufopts)

	local diagnostic_move_opts = { border = "rounded", float = false }

	nnoremap("gl", function()
		vim.diagnostic.open_float({ border = "rounded" })
	end, bufopts)
	nnoremap("]d", function()
		vim.diagnostic.goto_next(diagnostic_move_opts)
	end, bufopts)
	nnoremap("[d", function()
		vim.diagnostic.goto_prev(diagnostic_move_opts)
	end, bufopts)
	nnoremap("<leader>q", function()
		vim.diagnostic.setloclist()
	end, bufopts)
end

-- allows for context aware breadcrumbs
local breadcrumbs = function(client, bufnr)
	local status, navic = pcall(require, "nvim-navic")
	if not status then
		return
	end

	if client.server_capabilities.documentSymbolProvider then
		navic.setup({
			highlight = true,
			icons = {
				File = " ",
				Module = " ",
				Namespace = " ",
				Package = " ",
				Class = " ",
				Method = " ",
				Property = " ",
				Field = " ",
				Constructor = " ",
				Enum = " ",
				Interface = " ",
				Function = " ",
				Variable = " ",
				Constant = " ",
				String = " ",
				Number = " ",
				Boolean = " ",
				Array = " ",
				Object = " ",
				Key = " ",
				Null = " ",
				EnumMember = " ",
				Struct = " ",
				Event = " ",
				Operator = " ",
				TypeParameter = " ",
			},
		})
		navic.attach(client, bufnr)
	end
end

local highlight_augroup = vim.api.nvim_create_augroup("HighlightReferencesOnCursor", {})

local lsp_highlights = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd("CursorHold", {
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
		})
	end
end

-- if you want to set up formatting on save, you can use this as a callback
local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
	-- formatting on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = formatting_augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	lsp_keymaps(bufnr)
	lsp_highlights(client, bufnr)
	display_lsp_signature(bufnr)
	breadcrumbs(client, bufnr)
end

local protocol = require("vim.lsp.protocol")

M.capabilities = require("cmp_nvim_lsp").default_capabilities(protocol.make_client_capabilities())

return M
