local nnoremap = require("amar.keymap").nnoremap
local vnoremap = require("amar.keymap").vnoremap

-- exit into netrw
nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- navigate between windows
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- move text up and down (MacOS)
nnoremap("∆", ":m .+1<CR>") -- <A-j>
nnoremap("˚", ":m .-2<CR>") -- <A-k>
vnoremap("∆", ":m .+1<CR>gv") -- <A-j>
vnoremap("˚", ":m .-2<CR>gv") -- <A-k>
