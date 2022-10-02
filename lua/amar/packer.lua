local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim' -- Common utilities

  -- color theme
  -- use { 'ellisonleao/gruvbox.nvim' }
  -- use 'sainnhe/gruvbox-material'
  -- use 'kvrohit/rasmus.nvim'
  use 'lewpoly/sherbet.nvim'

  -- status line
  use 'nvim-lualine/lualine.nvim'

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- LSP config
  use 'neovim/nvim-lspconfig' -- enable lsp
  use 'onsails/lspkind-nvim' -- vscode-like pictograms

  -- completion
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- lsp completion source
  use 'hrsh7th/cmp-nvim-lua' -- nvim lua completion source
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  use 'hrsh7th/cmp-cmdline' -- command line completions

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use "rafamadriz/friendly-snippets"

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

  use 'norcalli/nvim-colorizer.lua'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
