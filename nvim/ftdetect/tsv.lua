local group = vim.api.nvim_create_augroup("SetTSVFiletype", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = group,
  callback = function()
    vim.bo.filetype = "tsv"
  end,
})
