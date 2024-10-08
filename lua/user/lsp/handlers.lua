local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			source = "if_many",
      header = "",
      prefix = ""
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		width = 60,
    focusable = false
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		width = 60,
    focusable = false
	})
end

local function lsp_highlight_document()
	-- Set autocommands conditional on server_capabilities
	--[[ local status_ok, illuminate = pcall(require, "illuminate") ]]
	--[[ if not status_ok then ]]
  vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
  ]], false)

  vim.api.nvim_exec([[
    augroup lsp_document_diagnostics
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.diagnostic.open_float({ border = "rounded", focusable = false })
    augroup END
  ]], false)
    --[[ return ]]
	--[[ end ]]
	--[[ illuminate.on_attach(client) ]]
	-- end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	--[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) ]]
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "g]", '<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "g[", '<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>', opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gl",
		'<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
		opts
	)
	--[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>', opts) ]]
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
end

M.on_attach = function(client, bufnr)
	-- vim.notify(client.name .. " starting...")
	-- TODO: refactor this into a method that checks if string in list
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end
	lsp_keymaps(bufnr)
  if client.supports_method('textDocument/documentHighlight') then
    lsp_highlight_document()
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

--[[ capabilities.textDocument.foldingRange = { ]]
--[[   dynamicRegistration = false, ]]
--[[   lineFoldingOnly = true ]]
--[[ } ]]

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
