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
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-n>", -- binding to scroll down inside the popup
    scroll_up = "<c-p>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 30 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    -- i = { "j", "k" },
    -- v = { "j", "k" },
  },
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
    ['-'] = { "", "Toggle narrowing" },
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
    c = { "", "Open project editorconfig" },
    -- C   - Copy this file
    -- d   - Find directory
    -- D   - Delete this file
    -- e   - Find file in emacs.d
    -- E   - Browse emacs.d
    -- f   - Find file
    -- F   - Find file from here
    -- l   - Locate file
    -- p   - Find file in private config
    -- P   - Browse private config
    -- r   - Recent files
    -- R   - Rename/move file
    -- s   - Save file
    s = { "<cmd>w!<CR>", "Save" },
    -- S   - Save file as...
    S = { "<cmd>w! ", "Save file as..." },
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
    P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Switch project" },
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

which_key.setup(setup)
which_key.register(doomMappings, opts)
