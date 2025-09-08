return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    picker = {
      enabled   = true,
      ui_select = true,
      sources = {
        select = {
          focus = "list",
          layout = {
            preset = "select",
            width  = 0.6,
            height = 0.5,
            border = "rounded",
          },
        },
      },
    },
  },
}
