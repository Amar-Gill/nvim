local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local protocol = require("vim.lsp.protocol")

local capabilities = require("cmp_nvim_lsp").update_capabilities(protocol.make_client_capabilities())

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

	vim.keymap.set("n", "<leader>dec", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "<leader>def", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>imp", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<leader>sig", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		lsp_formatting(bufnr)
	end, bufopts)

	vim.keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', bufopts)
	vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', bufopts)
	vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
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
