local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
  return
end

todo_comments.setup {
  signs = false,
  keywords = {
    TODO = { color = "warning" },
    FIXME = { color = "error" },
    NOTE = { color = "info" }
  },
  colors = {
    error = { "DiagnosticError", "ErrorMsg" },
    warning = { "Todo", "DiagnosticWarn", "WarningMsg" },
    info = { "Special" , "DiagnosticInfo" }
  },
  highlight = {
    before = "",
    keyword = "fg",
    after = ""
  }
}
