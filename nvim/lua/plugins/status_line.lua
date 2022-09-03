local present, lualine = pcall(require, "lualine")
if not present then
  return
end

local function environment_name()
  local ps1 = os.getenv("PS1")
  if ps1 then
    return string.match(ps1, "%((.+)%) ")
  else
    return ""
  end
end

lualine.setup({
  options = {
    theme = "tokyonight",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { environment_name },
    lualine_x = { "encoding" },
    lualine_y = { "filetype" },
    lualine_z = { "filename" },
  },
})
