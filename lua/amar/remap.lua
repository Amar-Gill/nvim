local Remap = require("amar.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

nnoremap("<leader>d", "<cmd>bd<CR>") -- delete current buffer

nnoremap("<leader>v", "<cmd>vsplit<CR>") -- new vertical window
nnoremap("<leader>w", "<C-w>c") -- close active window

nnoremap("<leader>bg", ':exec &bg=="light" ? "set bg=dark" : "set bg=light" <CR>') -- toggle light / dark bg

-- navigate between windows
nnoremap("z", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("m", "<C-w>l")

-- stay in visual mode when indenting blocks of text
vnoremap(">", ">gv")
vnoremap("<", "<gv")

-- move text up and down (MacOS)
nnoremap("∆", ":m .+1<CR>") -- <A-j>
nnoremap("˚", ":m .-2<CR>") -- <A-k>
vnoremap("∆", ":m .+1<CR>gv") -- <A-j>
vnoremap("˚", ":m .-2<CR>gv") -- <A-k>

-- clipboard remaps
-- keep pasted value in clipboard when pasting over other text
vnoremap("p", '"_dP')
xnoremap("p", '"_dP')

nnoremap("<leader>h", "<cmd>set hlsearch!<CR>") -- toggle highlight search
