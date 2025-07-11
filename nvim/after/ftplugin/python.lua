-- automatically add f-string qualifier
vim.api.nvim_create_autocmd("InsertCharPre", {
  group = vim.api.nvim_create_augroup("py-fstring", { clear = true }),
  buffer = 0,
  callback = function(params)
    if vim.v.char ~= "{" then
      return
    end

    local node = vim.treesitter.get_node({})

    if not node then
      return
    end

    if node:type() ~= "string" then
      node = node:parent()
    end

    if not node or node:type() ~= "string" then
      return
    end
    local row, col, _, _ = vim.treesitter.get_node_range(node)
    local first_char = vim.api.nvim_buf_get_text(params.buf, row, col, row, col + 1, {})[1]
    if first_char == "f" then
      return
    end

    vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<esc>`'la")
  end,
})

-- python-specific spellfile
vim.opt_local.spellfile = vim.fn.stdpath("config") .. "/spell/python.add"
