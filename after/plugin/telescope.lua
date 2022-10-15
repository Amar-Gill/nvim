local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local nnoremap = require("amar.keymap").nnoremap

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
				["/"] = function()
					vim.cmd.startinsert()
				end,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["D"] = fb_actions.remove,
					["R"] = fb_actions.rename,
					["h"] = fb_actions.goto_parent_dir,
				},
			},
		},
	},
})

telescope.load_extension("file_browser")

nnoremap("\\f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)

nnoremap("\\r", function()
	builtin.live_grep()
end)

nnoremap("\\B", function()
	builtin.buffers()
end)

nnoremap("\\t", function()
	builtin.help_tags()
end)

nnoremap("\\\\", function()
	builtin.resume()
end)

nnoremap("\\e", function()
	builtin.diagnostics()
end)

nnoremap("\\ls", function()
	builtin.lsp_document_symbols()
end)

nnoremap("\\s", function()
	builtin.git_status()
end)

nnoremap("\\c", function()
	builtin.git_commits()
end)

nnoremap("\\C", function()
	builtin.git_bcommits()
end)

nnoremap("\\b", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end)
