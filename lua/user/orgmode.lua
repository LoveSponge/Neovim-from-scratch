local status_ok_ayucolors, ayucolors = pcall(require, "ayu.colors")
if not status_ok_ayucolors then
  return
end
local status_ok, orgmode = pcall(require, "orgmode")
if not status_ok then
  return
end

vim.o.conceallevel=2
vim.o.concealcursor='nc'

--[[ hi link OrgTodo special ]]

--[[ orgmode.setup_ts_grammar() ]]

orgmode.setup {
  org_agenda_files = { "~/Sync/orgtasks/Tasks.org" },
  org_default_notes_file = "~/Sync/orgtasks/Tasks.org",
  org_todo_keywords = { "TODO(t)", "|", "DONE(d)", "CANCELLED(c)" },
  --[[ win_split_mode = { "float", 0.9 }, ]]
  --[[ org_todo_keyword_faces = { ]]
  --[[   TODO = ":foreground " .. ayucolors.accent ]]
  --[[ }, ]]
  org_hide_leading_stars = true,
  org_tags_column = -20,
  org_capture_templates = {
    t = "T-Rex",
    tt = {
      description = "Planned",
      template = "* TODO %? :@work:+trex:\n  SCHEDULED: <%<%Y-%m-%d %a>>"
    },
    tu = {
      description = "Unplanned",
      template = "* TODO %? :@work:+trex:unplanned:\n  SCHEDULED: <%<%Y-%m-%d %a>>"
    },
    e = "e-shot",
    et = {
      description = "Planned",
      template = "* TODO %? :@work:+eshot:\n  SCHEDULED: <%<%Y-%m-%d %a>>"
    },
    weu = {
      description = "Unplanned",
      template = "* TODO %? :@work:+eshot:unplanned:\n  SCHEDULED: <%<%Y-%m-%d %a>>"
    }
  }
}
