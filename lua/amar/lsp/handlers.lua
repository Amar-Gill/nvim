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

M.capabilities = require("cmp_nvim_lsp").update_capabilities(protocol.make_client_capabilities())

return M
