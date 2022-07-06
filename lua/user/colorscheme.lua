vim.cmd [[
try
  colorscheme ayu-mirage
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
