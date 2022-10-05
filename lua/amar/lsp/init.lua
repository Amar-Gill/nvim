local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local on_attach = require("amar.lsp.handlers").on_attach
local capabilities = require("amar.lsp.handlers").capabilities

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- get the language server to recognize the "vim" global
				globals = { "vim" },
			},
			workspace = {
				-- make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

-- set up null-ls
require("amar.lsp.null-ls")
