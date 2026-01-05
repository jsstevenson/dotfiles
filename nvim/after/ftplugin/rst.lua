-- header shortcuts
vim.keymap.set("n", "<leader>p", function()
  require("user.underline").prompt_and_underline()
end, { buffer = true, silent = true, desc = "Underline header (prompt char)" })
