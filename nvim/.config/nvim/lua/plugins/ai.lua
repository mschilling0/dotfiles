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
