return {
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    priority = 1000,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local is_mac = vim.fn.has('macunix') == 1
      local flavor = is_mac and 'catppuccin-latte' or 'catppuccin-mocha'
      vim.cmd.colorscheme(flavor)
    end,
  }
}
