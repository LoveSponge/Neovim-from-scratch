local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
  local opts = { silent = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<cmd>lua _LAZYGIT_TOGGLE()<CR>]], { noremap = true, silent = true })
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
	node:toggle()
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<cmd>lua _NODE_TOGGLE()<CR>]], { noremap = true, silent = true })
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
	ncdu:toggle()
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<cmd>lua _NCDU_TOGGLE()<CR>]], { noremap = true, silent = true })
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<cmd>lua _HTOP_TOGGLE()<CR>]], { noremap = true, silent = true })
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<cmd>lua _PYTHON_TOGGLE()<CR>]], { noremap = true, silent = true })
end
