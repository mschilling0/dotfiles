vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Toggle Explorer" })

vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() require("fzf-lua").live_grep() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fe", function() require("fzf-lua").diagnostics_document() end, { desc = "Diags" })
