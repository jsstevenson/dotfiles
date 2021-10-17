local cmd, g = vim.cmd, vim.g

cmd([[ let g:Hexokinase_optOutPatterns = [ 'colour_names' ] ]]) -- ?? why won't this work in lua

g.tokyonight_style = 'storm'
g.tokyonight_dark_float = false
g.tokyonight_colors = {}
cmd 'colorscheme tokyonight'
