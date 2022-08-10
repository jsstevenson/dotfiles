local group = vim.api.nvim_create_augroup("yaml_indent", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufEnter" }, {
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
  group = group,
  pattern = "*.yaml",
})
