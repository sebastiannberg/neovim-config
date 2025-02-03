return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "c", "lua", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc" },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    }
  end
}
