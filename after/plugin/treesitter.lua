local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"tsx",
		"json",
		"yaml",
		"css",
		"html",
		"lua",
		"typescript",
		"go",
		"gomod",
		"markdown",
		"python",
		"svelte",
		"vue",
		"dockerfile",
		"make",
		"rust",
		"bash",
		"sql",
	},
	autotag = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
