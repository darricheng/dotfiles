-- Set the default colorscheme for my editor
vim.cmd.colorscheme("monokai-pro")

require("no-neck-pain").setup({
	width = 100,
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

-- blankline indentation configs
require("ibl").setup({
	-- Setup config for indent_blankline goes here
	-- See :h ibl.setup for more info
	scope = {
		show_start = false,
		show_end = false,
	},
})

-- open undotree on the right and diff below
vim.g.undotree_WindowLayout = 2
-- width of the undotree window
vim.g.undotree_SplitWidth = 40
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndoTree" })

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "[Z]enMode" })
require("zen-mode").setup({
	plugins = {
		tmux = {
			enabled = true,
		},
	},
})

local notify = require("notify")
notify.setup({
	-- use non-opacity changing effect so that screen doesn't flicker
	stages = "slide",
	max_width = 80,
	max_height = 24,
	fps = 60,
	render = "wrapped-default",
})
-- open the message history in telescope
vim.keymap.set("n", "<leader>sm", function()
	require("telescope").extensions.notify.notify()
end, { desc = "[M]essage [S]earch" })
-- sometimes notifications block my work, so this is a quick
-- shortcut to dismiss them when I need to
vim.keymap.set("n", "<leader>nd", function()
	notify.dismiss({
		silent = true,
		pending = true,
	})
end, { desc = "[N]otifications [D]ismiss" })

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim

		-- false for monokai-pro, otherwise true probably works better in general,
		-- but definitely better for catppuccin
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},

	views = {
		cmdline_popup = {
			position = {
				row = 20,
				col = "50%",
			},
		},
		cmdline_popupmenu = {
			position = {
				row = 23,
				col = "50%",
			},
		},
	},
})
