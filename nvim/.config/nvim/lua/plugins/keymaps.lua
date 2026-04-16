if pcall(require, "nvim-tree") then
  vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
end

local status, fzf = pcall(require, "fzf-lua")
if status then
  vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
end
