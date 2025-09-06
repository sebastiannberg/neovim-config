return {
  "folke/trouble.nvim",
  keys = {
    { "<leader>dd", function() require("trouble").toggle("diagnostics", { focus = true }) end, desc = "Diagnostics (workspace)" },
  },
  opts = {
    win = {
      type = "float",
    },
    focus = true,
    auto_refresh = true,
    keys = {
      q = "close",
      o = "jump_close",
    },
  },
}
