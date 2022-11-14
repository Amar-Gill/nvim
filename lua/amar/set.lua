vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.incsearch = true

vim.opt.inccommand = "split"

vim.opt.smartindent = true

vim.opt.wrap = false

vim.g.mapleader = " "

vim.opt.cursorline = true
vim.opt.hlsearch = true

vim.opt.termguicolors = true

vim.opt.cmdheight = 0

vim.opt.laststatus = 3

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.clipboard = "unnamedplus"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 300

local get_winbar = function()
	local s = "%t"
	local status = pcall(require, "nvim-navic")
	if status then
		return s .. " %{%v:lua.require'nvim-navic'.get_location()%}"
	end
	return s
end

vim.o.winbar = get_winbar()
