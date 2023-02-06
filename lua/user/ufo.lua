local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  return
end

vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith)
--[[ vim.keymap.set('n', 'zo', ufo.closeFolds) ]]

ufo.setup {
  --[[ open_fold_hl_timeout = 150, ]]
  --[[ preview = { ]]
  --[[   win_config = { ]]
  --[[     winhighlight = 'Normal:Folded', ]]
  --[[     winblend = 0 ]]
  --[[   } ]]
  --[[ }, ]]
  provider_selector = function()
    return { 'treesitter', 'indent' }
  end
}
