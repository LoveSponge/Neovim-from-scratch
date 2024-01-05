local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
local status_ok_parsers, parsers = pcall(require, "nvim-treesitter.parsers")
if not status_ok_parsers then
	return
end

local parser_config = parsers.get_parser_configs()
--[[ parser_config.org = { ]]
--[[   install_info = { ]]
--[[     url = 'https://github.com/milisims/tree-sitter-org', ]]
--[[     revision = 'main', ]]
--[[     files = { 'src/parser.c', 'src/scanner.cc' } ]]
--[[   }, ]]
--[[   filetype = 'org' ]]
--[[ } ]]

configs.setup({
  ensure_installed = "all", -- one of "all" or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = false,
    disable = { "" }
  },
  --[[ additional_vim_regex_highlighting = {'org'} ]]
})
