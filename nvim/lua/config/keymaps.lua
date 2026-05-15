local map = vim.keymap.set

map("n", "<leader><leader>t", "<cmd>SetTpl<cr>", { silent = true, desc = "Set template" })
map("n", "<leader><cr>", "<cmd>noh<cr>", { silent = true, desc = "Clear search highlight" })

map("n", "j", "gj", { desc = "Move down by visual line" })
map("n", "k", "gk", { desc = "Move up by visual line" })
map("n", "0", "^", { desc = "Go to first non-blank character" })
