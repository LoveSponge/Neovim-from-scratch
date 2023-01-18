local status_ok, ayu = pcall(require, "ayu")
local colors_ok, colors = pcall(require, "ayu.colors")
if not status_ok or not colors_ok then
  return
end

colors.generate(true)

ayu.setup {
  overrides = {
    ['@tag'] = { fg = colors.tag },
    ['@tag.delimiter'] = { fg = "#0f6d80" },
    ['@tag.attribute'] = { fg = colors.func },
    ['@property'] = { fg = colors.fg },
    ['@variable.builtin'] = { fg = colors.fg },
    ['@include'] = { fg = colors.keyword }
  }
}
