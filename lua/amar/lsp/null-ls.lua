local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier,
		formatting.stylua,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.npm_groovy_lint,
		formatting.beautysh,
		formatting.gofmt,
		diagnostics.eslint,
		diagnostics.tidy,
		diagnostics.flake8,
		diagnostics.golangci_lint,
	},
})
