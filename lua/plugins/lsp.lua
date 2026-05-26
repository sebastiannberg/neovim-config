return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local on_attach = function(client, bufnr)
        if client.server_capabilities.semanticTokensProvider then
          print('✅ LSP: Semantic tokens enabled for ' .. client.name)
          vim.lsp.semantic_tokens.enable(true, { bufnr = bufnr })
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
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
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
              autoImportCompletions = false,
            },
          },
        },
      })
      vim.lsp.enable('basedpyright')

      -- java
      -- Dynamic workspace per detected project root to isolate projects.
      local jdtls_cache = vim.fn.stdpath("cache") .. "/jdtls"
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function()
          local root = vim.fs.root(0, { 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts', '.git' })
          local project_name = root and vim.fn.fnamemodify(root, ":t") or "default"
          require('jdtls').start_or_attach({
            name = 'jdtls',
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = root,
            cmd = {
              'jdtls',
              '--java-executable', '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin/java',
              '--jvm-arg=-Xmx4g',
              '--jvm-arg=-XX:+UseG1GC',
              '--jvm-arg=-XX:+UseStringDeduplication',
              '-data', jdtls_cache .. '/workspace/' .. project_name,
            },
            settings = {
              java = {
                contentProvider = { preferred = 'fernflower' },
              },
            },
          })
        end,
      })

      -- go
      vim.lsp.config('gopls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
      vim.lsp.enable('gopls')

      -- haskell
      vim.lsp.config('hls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          haskell = {
            formattingProvider = 'ormolu',
          },
        },
      })
      vim.lsp.enable('hls')

      -- vespa
      vim.lsp.config('vespa_ls', {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'java', '-jar', '/Users/sebasabe/.local/bin/vespa-language-server_2.4.9.jar' },
      })
      vim.lsp.enable('vespa_ls')

    end,
  },
}
