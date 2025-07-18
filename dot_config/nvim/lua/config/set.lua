-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Editor view settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true

-- Set vertical split to open on the right by default
vim.cmd([[set splitright]])

-- Set language so that I can paste UTF-8 characters like so:
-- 이 한국어를 붙였었요!
-- The important bit seems to be the part after the period, i.e. `UTF-8`.
-- Without it, when using `en_US`, and with the clipboard synced, it worked.
-- But without sync, i.e. need to use the + register to paste clipboard text,
-- the "+p command pasted `???`.
vim.api.nvim_exec2("language en_SG.UTF-8", {})

-- show diagnostic in float with borders
-- For the "gl", "[d", and "]d" shortcuts
vim.diagnostic.config({
	float = { border = "rounded", source = true },
	jump = { float = true },
})
