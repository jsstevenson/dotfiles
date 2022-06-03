local present, formatter = pcall(require, 'formatter')
if not present then
    return
end

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function format_prettier()
   return {
     exe = "npx",
     args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
     stdin = true
   }
end

formatter.setup {
  logging = true,
  filetype = {
    json = { format_prettier },
    html = { format_prettier },
    typescript = { format_prettier },
    typescriptreact = { format_prettier },
    yaml = { format_prettier }
    -- yaml = { require('formatter.filetypes.yaml').pyaml },
  }
}
map('n', '<leader>p', ':Format<cr>:w<cr>')
