-- coq_nvim autocomplete. settings must be set before local require
vim.g.coq_settings = {
	auto_start = "shut-up",
}
local coq = require("coq")

return coq
