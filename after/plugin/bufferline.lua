local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

local nnoremap = require("amar.keymap").nnoremap

bufferline.setup({
	options = {
		show_buffer_close_icons = false,
		show_close_icon = false,
		color_icons = true,
	},
})

nnoremap("<C-0>", "<Cmd>BufferLineCycleNext<CR>", {})
nnoremap("<C-9>", "<Cmd>BufferLineCyclePrev<CR>", {})
