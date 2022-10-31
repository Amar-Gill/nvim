local status, luasnip_vscode_loader = pcall(require, "luasnip.loaders.from_vscode")
if not status then
	return
end

luasnip_vscode_loader.lazy_load()
