-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim' -- Common utilities

    -- color theme
    -- use { 'ellisonleao/gruvbox.nvim' }
    -- use 'sainnhe/gruvbox-material'
    use 'kvrohit/rasmus.nvim'

    -- status line
    use 'nvim-lualine/lualine.nvim'

    -- icons
    use 'kyazdani42/nvim-web-devicons'

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

    -- auto close tags and brackets / parentheses
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    -- fuzzy finder
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'akinsho/nvim-bufferline.lua'

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
