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

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
	-- formatting on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	lsp_keymaps(bufnr)
end

local protocol = require("vim.lsp.protocol")

M.capabilities = require("cmp_nvim_lsp").default_capabilities(protocol.make_client_capabilities())

return M
