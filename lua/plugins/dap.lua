return {
  "mfussenegger/nvim-dap",
  enabled = false,
  keys = {
    { "<leader>dc", function() require("dap").continue() end, desc = "DAP Continue" },
    { "<leader>do", function() require("dap").step_over() end, desc = "DAP Step Over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "DAP Step Into" },
    { "<leader>du", function() require("dap").step_out() end, desc = "DAP Step Out" },
    { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
    { "<leader>dR", function() require("dap").repl.open() end, desc = "DAP REPL" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "DAP Run Last" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "DAP Terminate" },
  },
  config = function()
    local dap = require("dap")

    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Attach to Remote JVM",
        hostName = function()
          return vim.fn.input("Host [127.0.0.1]: ", "127.0.0.1")
        end,
        port = function()
          return tonumber(vim.fn.input("Port [5005]: ", "5005"))
        end,
      },
    }
  end,
}
