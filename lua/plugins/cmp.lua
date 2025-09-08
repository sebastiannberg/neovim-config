return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      vim.o.pumheight = 8
      local ELLIPSIS = "…"
      local W_ABBR = 40
      local W_KIND = 12
      local function strw(s) return vim.fn.strdisplaywidth(s) end
      local function cut(s, w)
        if strw(s) <= w then return s end
        return vim.fn.strcharpart(s, 0, w - 1) .. ELLIPSIS
      end
      local function pad(s, w)
        local len = strw(s)
        if len >= w then return s end
        return s .. string.rep(" ", w - len)
      end
      cmp.setup({
        completion = {
          keyword_length = 1,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = { { name = "nvim_lsp" } },
        formatting = {
          fields = { "kind", "abbr" },
          format = function(_, item)
            item.kind = pad(cut(item.kind or "", W_KIND), W_KIND)
            item.abbr = pad(cut(item.abbr or "", W_ABBR), W_ABBR)
            return item
          end,
        },
      })
    end,
  },
}
