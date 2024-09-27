local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  layout = {
    height = { min = 4, max = 30 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  show_help = true, -- show help message on the command line when the popup is visible
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  -- done
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  -- done
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  -- done
  ["w"] = { "<cmd>w!<CR>", "Save" },
  -- done
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  -- done
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  -- done
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  -- done
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  -- done
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

  -- added
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  -- done
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  -- done
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

local doomMappings = {
  -- RET - Jump to bookmark
  -- ['<cr>'] = { "", "Jump to bookmark" },
  -- SPC - Find file in project
  -- ['<space>'] = { "", "Find file in project" },
  -- ['<tab>'] - +Workspace
  -- '   - Resume last search
  -- *   - Search for symbol in project
  -- ,   - Switch workspace buffer
  -- .   - Find file
  ["<space>"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find file",
  },
  ["."] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find file",
  },
  -- /   - Search project
  ["/"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Search project" },
  -- ;   - Eval expr
  -- <   - Switch buffer
  -- `   - Switch to last buffer
  -- b   - +Buffer
  b = {
    name = "Buffer",
    -- -   - Toggle narrowing
    --[[ ['-'] = { "", "Toggle narrowing" }, ]]
    -- [   - Previous buffer
    ['['] = { "<cmd>bprevious<CR>", "Previous buffer" },
    p = { "<cmd>bprevious<CR>", "Previous buffer" },
    -- ]   - Next buffer
    n = { "<cmd>bnext<CR>", "Next buffer" },
    [']'] = { "<cmd>bnext<CR>", "Next buffer" },
    -- b   - Switch workspace buffer
    -- B   - Switch buffer
    B = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Switch buffer"
    },
    -- c   - Clone buffer
    -- d   - Kill buffer
    d = { "<cmd>Bdelete!<CR>", "Kill buffer" },
    -- i   - ibuffer
    -- k   - Kill buffer
    -- K   - Kill all buffers
    -- l   - Switch to last buffer
    -- m   - Set bookmark
    -- M   - Delete bookmark
    -- n   - Next buffer
    -- N   - New empty buffer
    -- O   - Kill other buffers
    -- p   - Previous buffer
    -- r   - Revert buffer
    -- s   - Save buffer
    -- S   - Save all buffers
    -- u   - Save buffer as root
    -- x   - Pop up scratch buffer
    -- X   - Switch to scratch buffer
  },
  -- c   - +Code
  c = {
    name = "Code",
    -- a   - LSP execute code action
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP code action" },
    -- c   - Compile
    -- C   - Recompile
    -- d   - Jump to definition
    -- D   - Jump to references
    -- e   - Evaluate buffer/region
    -- E   - Evaluate & replace region
    -- f   - Format buffer/region
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    -- i   - Find implementations
    -- j   - Jump to symbol in current workspace
    -- J   - Jump to symbol in any workspace
    -- k   - Jump to documentation
    -- l   - LSP
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
      d = {
        "<cmd>Telescope lsp_document_diagnostics<cr>",
        "Document diagnostics",
      },
      w = {
        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        "Workspace diagnostics",
      },
      f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer info" },
      j = {
        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        "Next diagnostic",
      },
      k = {
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
        "Prev diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens action" },
      q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace symbols",
      },
    },
    -- o   - LSP organise imports
    -- r   - LSP rename
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP rename" },
    -- s   - Send to repl
    -- t   - Find type  definition
    -- w   - Delete trailing whitespace
    -- W   - Delete trailing newlines
    -- x   - List errors
    x = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document diagnostics",
    },
  },
  -- f   - +File
  f = {
    name = "File",
    -- c   - Open project editorconfig
    c = { "e .editorconfig", "Open project editorconfig" },
    -- C   - Copy this file
    -- d   - Find directory
    -- D   - Delete this file
    -- e   - Find file in emacs.d
    -- E   - Browse emacs.d
    -- f   - Find file
    -- F   - Find file from here
    -- l   - Locate file
    -- p   - Find file in private config
    p = { "<cmd>cd ~/.config/nvim/ <cr><cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Find file in private config" },
    -- P   - Browse private config
    -- r   - Recent files
    -- R   - Rename/move file
    -- s   - Save file
    s = { "<cmd>w!<CR>", "Save" },
    -- S   - Save file as...
    S = { "<cmd>wa!<CR>", "Save all..." },
    -- u   - Sudo find file
    -- U   - Sudo this file
    -- y   - Yank file path
    -- Y   - Yank file path from project
  },
  -- g   - +Git
  g = {
    name = "Git",
    t = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Toggle Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
  -- h   - +Help
  -- i   - +Insert
  -- n   - +Notes
  -- o   - +Open
  o = {
    name = "Open",
    -- d = { "", "Start debugger" },
    p = { "<cmd>NvimTreeToggle<cr>", "Project sidebar" },
    -- P   - Find file in project sidebar
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node REPL" },
    t = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Toggle terminal popup" },
  },
  -- p   - +Project
  p = {
    name = "Project",
    -- .   - Browse project
    ['.'] = { "", "Browse project" },
    -- >   - Browse other project
    -- a   - Add new project
    -- b   - Switch to project buffer
    -- d   - Remove known project
    -- D   - Discover projects in folder
    -- f   - Find file in project
    -- F   - Find file in other project
    -- p   - Switch project
    p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Switch project" },
    -- s   - Save project files
    -- t   - List project todos
    -- x   - Pop up scratch buffer
  },
  -- q   - +Quit/session
  q = {
    name = "Quit/Session",
    -- l   - Restore last session
    ['l'] = { "", "Restore last session" },
    -- L   - Restore session from file
    -- q   - Quit Neovim
    q = { "<cmd>wqa!<CR>", "Quit" },
    -- Q   - Quit Neovim without saving
    Q = { "<cmd>qa!<CR>", "Quit without saving" },
    -- r   - Restart and restore Neovim
    -- R   - Restart Neovim
    -- s   - Quick save current session
    -- S   - Save session to file
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
  },
  w = {
    name = "Window",
    d = { "<cmd>q<cr>", "Close window" }
  }
  -- r   - +Remote
  -- s   - +Search
  -- t   - +Toggle
    -- b   - Big mode
    -- c   - Fill column indicator
    -- f[lycheck] - ? lsp errors?
    -- f   - Fullscreen
    -- i   - Indent guides
    -- I   - Indent style
    -- l   - Line numbers
    -- r   - Read-only mode
    -- w   - Soft line wrapping
}

local updated_mappings = {
  { "<leader>.", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find file", nowait = true, remap = false },
  { "<leader>/", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Search project", nowait = true, remap = false },
  { "<leader><space>", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find file", nowait = true, remap = false },
  { "<leader>b", group = "Buffer", nowait = true, remap = false },
  { "<leader>bB", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Switch buffer", nowait = true, remap = false },
  { "<leader>b[", "<cmd>bprevious<CR>", desc = "Previous buffer", nowait = true, remap = false },
  { "<leader>b]", "<cmd>bnext<CR>", desc = "Next buffer", nowait = true, remap = false },
  { "<leader>bd", "<cmd>Bdelete!<CR>", desc = "Kill buffer", nowait = true, remap = false },
  { "<leader>bn", "<cmd>bnext<CR>", desc = "Next buffer", nowait = true, remap = false },
  { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous buffer", nowait = true, remap = false },
  { "<leader>c", group = "Code", nowait = true, remap = false },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "LSP code action", nowait = true, remap = false },
  { "<leader>cf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format", nowait = true, remap = false },
  { "<leader>cl", group = "LSP", nowait = true, remap = false },
  { "<leader>clI", "<cmd>LspInstallInfo<cr>", desc = "Installer info", nowait = true, remap = false },
  { "<leader>clS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols", nowait = true, remap = false },
  { "<leader>cla", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code action", nowait = true, remap = false },
  { "<leader>cld", "<cmd>Telescope lsp_document_diagnostics<cr>", desc = "Document diagnostics", nowait = true, remap = false },
  { "<leader>clf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format", nowait = true, remap = false },
  { "<leader>cli", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
  { "<leader>clj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next diagnostic", nowait = true, remap = false },
  { "<leader>clk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev diagnostic", nowait = true, remap = false },
  { "<leader>cll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens action", nowait = true, remap = false },
  { "<leader>clq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
  { "<leader>clr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
  { "<leader>cls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols", nowait = true, remap = false },
  { "<leader>clw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace diagnostics", nowait = true, remap = false },
  { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "LSP rename", nowait = true, remap = false },
  { "<leader>cx", "<cmd>Telescope lsp_document_diagnostics<cr>", desc = "Document diagnostics", nowait = true, remap = false },
  { "<leader>f", group = "File", nowait = true, remap = false },
  { "<leader>fS", "<cmd>wa!<CR>", desc = "Save all...", nowait = true, remap = false },
  { "<leader>fc", "e .editorconfig", desc = "Open project editorconfig", nowait = true, remap = false },
  { "<leader>fp", "<cmd>cd ~/.config/nvim/ <cr><cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find file in private config", nowait = true, remap = false },
  { "<leader>fs", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
  { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
  { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
  { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false },
  { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false },
  { "<leader>gt", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Toggle Lazygit", nowait = true, remap = false },
  { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
  { "<leader>o", group = "Open", nowait = true, remap = false },
  { "<leader>on", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node REPL", nowait = true, remap = false },
  { "<leader>op", "<cmd>NvimTreeToggle<cr>", desc = "Project sidebar", nowait = true, remap = false },
  { "<leader>ot", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Toggle terminal popup", nowait = true, remap = false },
  { "<leader>p", group = "Project", nowait = true, remap = false },
  { "<leader>p.", "", desc = "Browse project", nowait = true, remap = false },
  { "<leader>pp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Switch project", nowait = true, remap = false },
  { "<leader>q", group = "Quit/Session", nowait = true, remap = false },
  { "<leader>qQ", "<cmd>qa!<CR>", desc = "Quit without saving", nowait = true, remap = false },
  { "<leader>ql", "", desc = "Restore last session", nowait = true, remap = false },
  { "<leader>qp", group = "Packer", nowait = true, remap = false },
  { "<leader>qpS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = true, remap = false },
  { "<leader>qpc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = true, remap = false },
  { "<leader>qpi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = true, remap = false },
  { "<leader>qps", "<cmd>PackerSync<cr>", desc = "Sync", nowait = true, remap = false },
  { "<leader>qpu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = true, remap = false },
  { "<leader>qq", "<cmd>wqa!<CR>", desc = "Quit", nowait = true, remap = false },
  { "<leader>w", group = "Window", nowait = true, remap = false },
  { "<leader>wd", "<cmd>q<cr>", desc = "Close window", nowait = true, remap = false },
}

which_key.setup(setup)
which_key.register(doomMappings, opts)
