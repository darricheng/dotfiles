-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Center editor around cursor when scrolling vertically
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Center editor when repeating the search with / or ?
-- zz centers the cursor line in the middle of the screen,
-- zv should take care of folds if any
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Use when pasting over text in visual mode
-- This will retain the original text in the register so you can paste it again
-- As compared to normal p to paste which will replace the register with the deleted word
-- vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste text and retain register' })
-- NOTE: Leaving this here as a reminder. I can just use capital P to paste over text in visual mode to retain the text in the register

-- Delete text without putting it in the register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete text into black hole" })

-- Copy filename stuff
vim.keymap.set("n", "<leader>cf", [[<cmd>let @+=expand("%:t")<CR>]], { desc = "Copy filename" })
vim.keymap.set("n", "<leader>cp", [[<cmd>let @+=expand("%:p")<CR>]], { desc = "Copy absolute filepath" })
vim.keymap.set("n", "<leader>cr", [[<cmd>let @+=expand("%")<CR>]], { desc = "Copy relative filepath" })
vim.keymap.set("n", "<leader>cd", [[<cmd>let @+=expand("%:p:h")<CR>]], { desc = "Copy directory name" })

-- I use the command :E to exit files and go back to the file explorer
-- :E actually calls :Explore when there are no other commands starting with E
-- This remap maintains the :E shortcut to go back to the file explorer
vim.api.nvim_create_user_command("E", "Explore", {})
-- Similarly, :O for :Oil, because there's other commands starting with O
vim.api.nvim_create_user_command("O", "Oil", {})
