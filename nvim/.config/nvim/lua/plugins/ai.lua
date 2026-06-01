-- nvim/.config/nvim/lua/plugins/ai.lua

require("plenary")

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
        },
      },
    })
  end,
  once = true,
})
require("CopilotChat").setup({
  model = "claude-opus-4.7",
})

require("sidekick").setup({
   nes = { enabled = false },
})

require("snacks").setup({
  terminal = { enabled = true },
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  notifier = { enabled = true },
  input = { enabled = true },
  words = { enabled = true },
  bufdelete = { enabled = true },
  rename = { enabled = true },
  gitbrowse = { enabled = true },
  scratch = { enabled = true },
  zen = { enabled = true },
  toggle = { enabled = true },
  picker = {
    ui_select = false,
    sources = {
      explorer = { hidden = true },
    },
  },
  explorer = { replace_netrw = true },
})
