-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- color theme
    use { 'ellisonleao/gruvbox.nvim' }

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- LSP config
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim' -- vscode-like pictograms

    -- completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-cmdline'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = 'TSUpdate'
    }

    -- coq.nvim completion. not using for now.
    --use {
    --    'ms-jpq/coq_nvim',
    --    branch = 'coq'
    --}
    --use {
    --    'ms-jpq/coq.artifacts',
    --    branch = 'artifacts'
    --}
end)
