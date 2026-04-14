return {
  "RRethy/vim-illuminate",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      providers = { "lsp", "treesitter", "regex" },
      delay = 250,
      filetypes_denylist = { "help", "lazy" },
      large_file_overrides = {
        providers = { "regex" },
      },
      min_count_to_highlight = 1,
    })
  end,
}
