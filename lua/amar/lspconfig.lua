local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local capabilities = require('cmp_nvim_lsp').update_capabilities(protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
    -- formatting
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
        vim.api.nvim_command [[augroup END]]
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>dec', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>def', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>imp', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>sig', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                -- get the language server to recognize the "vim" global
                globals = { 'vim' }
            },
            workspace = {
                -- make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
}
