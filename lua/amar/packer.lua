local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Autocommand that reloads neovim whenever you save the packer.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

packer.init({
	display = {
		open_fn = function()
			-- Close current window if it is floating, so floating packer window may open
			local current_window = vim.api.nvim_get_current_win()
			local current_window_config = vim.api.nvim_win_get_config(current_window)
			if current_window_config.zindex then
				vim.api.nvim_win_close(0, true)
			end
			-- Have packer use a popup window
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- Common utilities

	-- color themes
	use("kvrohit/rasmus.nvim")
	use("lewpoly/sherbet.nvim")
	use("kyazdani42/blue-moon")
	use("numToStr/Sakura.nvim")
	use("rose-pine/neovim")

	-- status line
	use("nvim-lualine/lualine.nvim")

	-- icons
	use("kyazdani42/nvim-web-devicons")

	-- LSP config
	use("neovim/nvim-lspconfig") -- enable lsp
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("jose-elias-alvarez/null-ls.nvim")

	-- completion
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-nvim-lsp") -- lsp completion source
	use("hrsh7th/cmp-nvim-lua") -- nvim lua completion source
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-cmdline") -- command line completions

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = "TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- auto close tags and brackets / parentheses
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- fuzzy finder
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")

	use("akinsho/nvim-bufferline.lua")

	use("norcalli/nvim-colorizer.lua")

	-- git
	use("lewis6991/gitsigns.nvim")

	-- comments
	use("numToStr/Comment.nvim")

	use("towolf/vim-helm")

	use({ "akinsho/toggleterm.nvim", tag = "*" })

	use("lewis6991/impatient.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		packer.sync()
	end
end)
