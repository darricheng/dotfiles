require("config")
require("config.remap")
require("config.set")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	-- editor stuff
	{ src = "https://github.com/shortcuts/no-neck-pain.nvim", version = vim.version.range("*") },
	"https://github.com/tpope/vim-abolish",
	{ src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("*") },
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/folke/todo-comments.nvim",
})

vim.cmd.colorscheme("catppuccin-macchiato")

require("no-neck-pain").setup({
	width = 100,
	fallbackOnBufferDelete = false,
	autocmds = {
		enableOnVimEnter = false,
	},
	mappings = {
		-- enables key mappings for no-neck-pain
		enabled = true,
		-- toggle the plugin
		toggle = "<leader>np",
		-- increase the width (+5) of the main window.
		widthUp = "<leader>n+",
		-- decrease the width (-5) of the main window.
		widthDown = "<leader>n-",
		-- toggle the scratchpad feature.
		scratchPad = "<leader>ns",
		debug = "<Leader>nD",
	},
})
-- NoNeckPain can be a bit buggy when more than one window is open,
-- so this keymap resets the state of the windows by toggling the plugin twice
vim.keymap.set("n", "<leader>nr", function()
	vim.cmd.NoNeckPain()
	-- calling the function twice b2b didn't work after upgrading nvim to 0.10
	-- would only be equal to calling the fn once
	-- calling the second instance separately in a defer_fn seems to work fine
	vim.defer_fn(function()
		vim.cmd.NoNeckPain()
	end, 100)
end, { desc = "[N]oNeckPain: Reset (double toggle)" })

require("Comment").setup()
require("nvim-autopairs").setup()
require("ibl").setup({
	-- Setup config for indent_blankline goes here
	-- See :h ibl.setup for more info
	scope = {
		show_start = false,
		show_end = false,
	},
})

require("todo-comments").setup()
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
vim.keymap.set("n", "<leader>st", function()
	Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "BUG", "ISSUE" } })
end, { desc = "Todo/Fix/Fixme" })
