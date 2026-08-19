return {
  "folke/trouble.nvim",
  enabled = false,
  keys = {
    { "<leader>dd", function() require("trouble").toggle("diagnostics", { focus = true }) end, desc = "Diagnostics (workspace)" },
  },
  opts = {
    focus = true,
    auto_refresh = true,
    keys = {
      q = "close",
      o = "jump_close",
    },
  },
}
