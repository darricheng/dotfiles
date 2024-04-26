-- to force the tmux navigator binding in netrw
-- otherwise it'll be some default refresh command
vim.keymap.set('n', '<c-l>', ':TmuxNavigateRight<CR>', {
  silent = true,
  buffer = true,
})
