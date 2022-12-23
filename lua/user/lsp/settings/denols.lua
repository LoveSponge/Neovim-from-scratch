local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

return {
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")
}
