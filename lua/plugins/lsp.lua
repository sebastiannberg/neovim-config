return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'basedpyright', 'clangd' },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      local on_attach = function(client, bufnr)
        -- enable LSP semantic tokens
        if client.server_capabilities.semanticTokensProvider then
          print('✅ LSP: Semantic tokens enabled for ' .. client.name)
          vim.lsp.semantic_tokens.start(bufnr, client.id)
        else
          print('❌ LSP: Semantic tokens disabled for ' .. client.name)
        end

        -- LSP keymaps
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      end

      -- lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- python
      lspconfig.basedpyright.setup({
        on_attach = on_attach,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'basic',
            },
          },
        },
      })

      -- C/C++
      lspconfig.clangd.setup({
        on_attach = on_attach,
      })

    end,
  },
}

