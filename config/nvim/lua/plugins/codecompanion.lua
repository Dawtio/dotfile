return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY", -- read os.getenv(ANTHROPIC_API_KEY)
            },
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = "anthropic",
        variables = {},
        slash_commands = {
          ["files"] = {
            path = "interactions.chat.slash_commands.builtin.file",
            opts = { provider = "snacks", },
          },
        },
      },
      inline = { adapter = "anthropic", },
      cmd = { adapter = "anthropic", },
      agent = { adapter = "anthropic" },
    },
  },
}
