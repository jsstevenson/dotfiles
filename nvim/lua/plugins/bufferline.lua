local Plugin = { "akinsho/bufferline.nvim" }

Plugin.event = "VeryLazy"

Plugin.opts = {
  options = {
    mode = "buffers",
    -- offsets = {
    --   { filetype = "NvimTree" },
    -- },
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
    end
  },
  highlights = {
    buffer_selected = {
      italic = false,
    },
    indicator_selected = {
      fg = { attribute = "fg", highlight = "Function" },
      italic = false,
    },
  },
}

return Plugin
