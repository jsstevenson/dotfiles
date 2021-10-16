local cmd, g = vim.cmd, vim.g
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'termguicolors', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('o', 'showmatch', true)
opt('w', 'cc', '80,100')
opt('w', 'cursorline', true)
opt('o', 'syntax', 'disable') -- theoretically treesitter covers this better
opt('o', 'showmode', false)  -- ????
cmd([[ let g:Hexokinase_optOutPatterns = [ 'colour_names' ] ]]) -- ?? why won't this work in lua
cmd('set signcolumn=yes:1')

g.tokyonight_style = 'storm'
g.tokyonight_dark_float = false
g.tokyonight_colors = {}
cmd 'colorscheme tokyonight'

local function environment_name()
    local ps1 = os.getenv('PS1')
    if ps1 then
        return string.match(ps1, "%((.+)%) ")
    else
        return nil
    end
end

require('lualine').setup{
    options = {
        theme = 'tokyonight'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {environment_name},
        lualine_x = {'encoding'},
        lualine_y = {'filetype'},
        lualine_z = {'filename'}
    }
}

require('bufferline').setup{}
