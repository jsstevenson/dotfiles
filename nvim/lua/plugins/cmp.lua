-- TODO
-- * figure out snippets - https://lsp-zero.netlify.app/v3.x/template/opinionated.html
local Plugin = {
  "saghen/blink.cmp",
  version = "1.*",
}

Plugin.opts = {
  sources = { default = { "lsp", "path", "buffer" } } ,
}
Plugin.opts_extend = {"sources.default"}
Plugin.dependencies = {
  { "windwp/nvim-autopairs"}
}

return Plugin
