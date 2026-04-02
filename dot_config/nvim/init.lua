require("config")
require("config.remap")
require("config.set")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/shortcuts/no-neck-pain.nvim", version = vim.version.range("*") },
	"https://github.com/tpope/vim-abolish",
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
