-- nvim/.config/nvim/lua/plugins/ai.lua

require("plenary")

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("copilot").setup({
      suggestion = { auto_trigger = true }
    })
  end,
  once = true,
})

require("CopilotChat").setup({
  model = "gemini-3.1-pro-preview",
})

require("sidekick").setup({
   nes = { enabled = false },
})
