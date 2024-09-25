vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = "*.vcf",
  callback = function()
    vim.bo.filetype = 'vcf'
  end
})
