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

nvim_lsp.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.tailwindcss.setup({
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
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "sh", "zsh", "bash" },
})

local groovyls_dir = os.getenv("HOME") .. "/groovy-language-server/build/libs/groovy-language-server-all.jar"
nvim_lsp.groovyls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "java", "-jar", groovyls_dir },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cadence",
	callback = function()
		vim.lsp.start({
			name = "cadence-language-server",
			cmd = { "flow", "cadence", "language-server" },
			root_dir = vim.fs.dirname(vim.fs.find({ "flow.json" }, { upward = true })[1]),
		})
	end,
})
