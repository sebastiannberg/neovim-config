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
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
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
      -- Keep JDTLS launcher via Homebrew symlink and sync its config into a writable cache.
      local home = "/opt/homebrew/opt/jdtls/libexec"
      local launcher = vim.fn.glob(home .. "/plugins/org.eclipse.equinox.launcher_*.jar")
      local config_src = home .. "/config_mac_arm"
      local cache_root = vim.fn.stdpath("cache") .. "/jdtls"
      local config_dst = cache_root .. "/config_mac_arm"
      local stamp = config_dst .. "/.jdtls-version"
      -- Use checksum of source config.ini so ANY plugin version change triggers re-sync
      local src_hash = vim.fn.trim(vim.fn.system({ "shasum", "-a", "256", config_src .. "/config.ini" }))

      if vim.fn.filereadable(stamp) == 0 or vim.fn.readfile(stamp)[1] ~= src_hash then
        vim.fn.delete(config_dst, "rf")
        vim.fn.mkdir(config_dst, "p")
        vim.fn.system({ "rsync", "-a", config_src .. "/", config_dst .. "/" })
        vim.fn.writefile({ src_hash }, stamp)
      end

      -- Use project-specific workspace to isolate projects and prevent cross-contamination
      local function get_jdtls_workspace()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        return cache_root .. "/workspace/" .. project_name
      end

      vim.lsp.config('jdtls', {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          -- Use Java 25 to run jdtls; shell JAVA_HOME can stay on 17
          "/opt/homebrew/Cellar/openjdk/25.0.2/libexec/openjdk.jdk/Contents/Home/bin/java",
          -- Increase heap for large projects like AWS SDK
          "-Xmx4g",
          "-XX:+UseG1GC",
          "-XX:+UseStringDeduplication",
          "-Dosgi.logfile=" .. cache_root .. "/jdtls.log",
          "-jar", launcher,
          "-configuration", config_dst,
          "-data", get_jdtls_workspace(),
        },
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
