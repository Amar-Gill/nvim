local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local on_attach = require("amar.lsp.handlers").on_attach
local capabilities = require("amar.lsp.handlers").capabilities

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
