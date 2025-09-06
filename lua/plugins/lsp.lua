return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local on_attach = function(client, bufnr)
        if client.server_capabilities.semanticTokensProvider then
          print('✅ LSP: Semantic tokens enabled for ' .. client.name)
          vim.lsp.semantic_tokens.start(bufnr, client.id)
        else
          print('❌ LSP: Semantic tokens disabled for ' .. client.name)
        end
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- lua
      vim.lsp.config('lua_ls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- python
      vim.lsp.config('basedpyright', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'basic',
            },
          },
        },
      })
      vim.lsp.enable('basedpyright')

      -- java
      vim.lsp.config('jdtls', {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      vim.lsp.enable('jdtls')

      -- vespa
      vim.lsp.config('vespa_ls', {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'java', '-jar', '/Users/sebasabe/lsp/vespa-language-server_2.4.4.jar' },
      })
      vim.lsp.enable('vespa_ls')

    end,
  },
}
