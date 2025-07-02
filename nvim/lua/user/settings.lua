local cmd = vim.cmd
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

vim.o.termguicolors = true
opt("w", "number", true)
opt("w", "relativenumber", true)
opt("o", "showmatch", true)
opt("w", "cc", "80,88")
opt("w", "cursorline", true)
vim.o.syntax = "disable" -- covered by treesitter
vim.o.showmode = false
cmd("set signcolumn=yes:1") -- for lsp issues?  TODO return to this
vim.o.winborder = "single"

opt("b", "expandtab", true)
-- opt("b", "fileencoding", "utf-8")
opt("o", "wildmode", "longest,list")
opt("b", "shiftwidth", 4)
opt("b", "softtabstop", 4)

vim.o.visualbell = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.scrolloff = 2
opt("o", "inccommand", "nosplit")

-- spelling
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.api.nvim_create_user_command("MkSpellFT", function()
  local spellfiles = vim.opt_local.spellfile:get()
  if not spellfiles or #spellfiles == 0 then
    print("No spellfile set for this buffer")
    return
  end

  for _, spellfile in ipairs(spellfiles) do
    vim.cmd("mkspell! " .. spellfile)
    print("Compiled spellfile: " .. spellfile)
  end
end, {})

-- disable unused stuff
local disabled_built_ins = {
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "spellfile_plugin",
  "tutor",
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
