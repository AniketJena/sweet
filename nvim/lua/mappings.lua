require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("c", "<C-s>", ":w !wl-copy<CR><CR>", { noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
