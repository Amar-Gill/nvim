local nnoremap = require("amar.keymap").nnoremap
local vnoremap = require("amar.keymap").vnoremap

nnoremap("<leader>pv", "<cmd>Ex<CR>") -- exit into netrw
nnoremap("<leader>d", "<cmd>bd<CR>") -- delete current buffer

nnoremap("<leader>v", "<cmd>vsplit<CR>") -- new vertical window
nnoremap("<leader>w", "<C-w>c") -- close active window
-- navigate between windows
nnoremap("<S-Tab>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<Tab>", "<C-w>l")

-- stay in visual mode when indenting blocks of text
vnoremap(">", ">gv")
vnoremap("<", "<gv")

-- move text up and down (MacOS)
nnoremap("∆", ":m .+1<CR>") -- <A-j>
nnoremap("˚", ":m .-2<CR>") -- <A-k>
vnoremap("∆", ":m .+1<CR>gv") -- <A-j>
vnoremap("˚", ":m .-2<CR>gv") -- <A-k>

-- clipboard remaps
vnoremap("p", '"_dP')
