local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load("user.settings")
load("user.commands")
load("user.mappings")
require("config.lazy")

-- must be after plugin config
pcall(vim.cmd.colorscheme, "tokyonight")
