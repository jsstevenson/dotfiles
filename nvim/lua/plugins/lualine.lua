-- TODO
-- * don't use different backgrounds for each section
-- * just use a minimal line separator
-- * provide full path for file?
local Plugin = { "nvim-lualine/lualine.nvim" }
Plugin.dependencies = { "nvim-tree/nvim-web-devicons", lazy = true }

function Plugin.config()
  -- TODO add more flexible options for other kinds of files?
  -- ideally target prompt under PS1 var but that doesn't seem to be working right now
  local function environment_name()
    local ps1 = os.getenv("VIRTUAL_ENV_PROMPT")
    if ps1 then
      return ps1
    else
      return ""
    end
  end

  require("lualine").setup({
    options = {
      theme = "tokyonight",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch", use_mode_colors = false } },
      lualine_c = { environment_name },
      lualine_x = { "encoding" },
      lualine_y = { "filetype" },
      lualine_z = { { "filename", color = {} } },
    },
  })
end

return Plugin
