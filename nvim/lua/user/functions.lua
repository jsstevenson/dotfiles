local M = {}

function M.underline_line(ch)
  if not ch or ch == "" then
    return
  end
  ch = ch:sub(1, 1)

  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()

  local indent = line:match("^%s*") or ""
  local text = line:gsub("^%s*", "")
  local width = vim.fn.strdisplaywidth(text)

  local underline = indent .. string.rep(ch, width)

  local buf = 0
  local last = vim.api.nvim_buf_line_count(buf)

  if row >= last then
    vim.api.nvim_buf_set_lines(buf, row, row, true, { underline })
    return
  end

  local next_line = vim.api.nvim_buf_get_lines(buf, row, row + 1, true)[1] or ""
  local pat = "^" .. vim.pesc(indent) .. vim.pesc(ch) .. "+%s*$"

  if next_line:match(pat) then
    -- replace existing underline line
    vim.api.nvim_buf_set_lines(buf, row, row + 1, true, { underline })
  else
    -- insert underline line
    vim.api.nvim_buf_set_lines(buf, row, row, true, { underline })
  end
end

function M.prompt_and_underline()
  local ok, key = pcall(vim.fn.getcharstr)
  if not ok or not key or key == "" then
    return
  end
  M.underline_line(key)
end

return M
