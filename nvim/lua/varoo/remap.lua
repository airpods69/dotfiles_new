vim.g.mapleader = " "
vim.keymap.set("n", "<leader>n", vim.cmd.Ex)
-- This one is to not let paste hurt me
vim.keymap.set("x", "<leader>p", [["_dP]])

-- For next and previous tab
vim.keymap.set("n", "<Tab>", vim.cmd.bnext)
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprev)

-- For closing current buffer
vim.keymap.set("n", "<leader>x", vim.cmd.bd)
