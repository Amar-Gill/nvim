-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use { 'ellisonleao/gruvbox.nvim' }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'neovim/nvim-lspconfig' -- LSP config
    -- coq.nvim autocompletion
    --use {
    --    'ms-jpq/coq_nvim',
    --    branch = 'coq'
    --}
    --use {
    --    'ms-jpq/coq.artifacts',
    --    branch = 'artifacts'
    --}
end)
