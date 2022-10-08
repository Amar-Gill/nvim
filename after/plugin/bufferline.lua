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

-- MacOS specific
nnoremap("ß", "<Cmd>BufferLineCycleNext<CR>", {}) -- <A-s>
nnoremap("å", "<Cmd>BufferLineCyclePrev<CR>", {}) -- <A-a>
