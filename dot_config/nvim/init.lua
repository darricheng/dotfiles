require("config")
require("config.remap")
require("config.set")

---@param modes string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
local map = function(modes, lhs, rhs, opts)
	vim.keymap.set(modes, lhs, rhs, opts)
end

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	"https://github.com/folke/snacks.nvim",

	-- editor stuff
	{ src = "https://github.com/shortcuts/no-neck-pain.nvim", version = vim.version.range("*") },
	"https://github.com/tpope/vim-abolish",
	{ src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("*") },
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/folke/todo-comments.nvim",

	-- Formatting
	"https://github.com/stevearc/conform.nvim",
})

vim.cmd.colorscheme("catppuccin-macchiato")

local snacks = require("snacks")
snacks.setup({
	input = {},
	-- TODO: Change keymaps that use the meta key
	-- See: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
	picker = {
		main = {
			-- When using picker from Oil, this ensures the same buffer is used even
			-- if a vertically split pane is open.
			file = false,
		},
	},
})
-- NOTE: Picker keys
-- Top Pickers & Explorer
map("n", "<leader><space>", function()
	snacks.picker.smart()
end, { desc = "Smart Find Files" })
map("n", "<leader>,", function()
	snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>:", function()
	snacks.picker.command_history()
end, { desc = "Command History" })
-- find
map("n", "<leader>ff", function()
	snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
	snacks.picker.git_files()
end, { desc = "Find Git Files" })
map("n", "<leader>fr", function()
	snacks.picker.recent()
end, { desc = "Recent" })
-- git
map("n", "<leader>gb", function()
	snacks.picker.git_branches()
end, { desc = "Git Branches" })
map("n", "<leader>gl", function()
	snacks.picker.git_log()
end, { desc = "Git Log" })
map("n", "<leader>gL", function()
	snacks.picker.git_log_line()
end, { desc = "Git Log Line" })
map("n", "<leader>gs", function()
	snacks.picker.git_status()
end, { desc = "Git Status" })
map("n", "<leader>gS", function()
	snacks.picker.git_stash()
end, { desc = "Git Stash" })
map("n", "<leader>gd", function()
	snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", function()
	snacks.picker.git_log_file()
end, { desc = "Git Log File" })
-- Grep
map("n", "<leader>sb", function()
	snacks.picker.lines()
end, { desc = "Buffer Lines" })
map("n", "<leader>sB", function()
	snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
map("n", "<leader>sg", function()
	snacks.picker.grep()
end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function()
	snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
-- search
map("n", '<leader>s"', function()
	snacks.picker.registers()
end, { desc = "Registers" })
map("n", "<leader>s/", function()
	snacks.picker.search_history()
end, { desc = "Search History" })
map("n", "<leader>sa", function()
	snacks.picker.autocmds()
end, { desc = "Autocmds" })
map("n", "<leader>sb", function()
	snacks.picker.lines()
end, { desc = "Buffer Lines" })
map("n", "<leader>sc", function()
	snacks.picker.command_history()
end, { desc = "Command History" })
map("n", "<leader>sC", function()
	snacks.picker.commands()
end, { desc = "Commands" })
map("n", "<leader>sd", function()
	snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>sD", function()
	snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function()
	snacks.picker.help()
end, { desc = "Help Pages" })
map("n", "<leader>sH", function()
	snacks.picker.highlights()
end, { desc = "Highlights" })
map("n", "<leader>si", function()
	snacks.picker.icons()
end, { desc = "Icons" })
map("n", "<leader>sj", function()
	snacks.picker.jumps()
end, { desc = "Jumps" })
map("n", "<leader>sk", function()
	snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>sl", function()
	snacks.picker.loclist()
end, { desc = "Location List" })
map("n", "<leader>sm", function()
	snacks.picker.marks()
end, { desc = "Marks" })
map("n", "<leader>sM", function()
	snacks.picker.man()
end, { desc = "Man Pages" })
map("n", "<leader>sp", function()
	snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })
map("n", "<leader>sq", function()
	snacks.picker.qflist()
end, { desc = "Quickfix List" })
map("n", "<leader>sR", function()
	snacks.picker.resume()
end, { desc = "Resume" })
map("n", "<leader>su", function()
	snacks.picker.undo()
end, { desc = "Undo History" })
map("n", "<leader>Cs", function()
	snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
-- LSP
map("n", "gd", function()
	snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
map("n", "gD", function()
	snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
map("n", "grr", function()
	snacks.picker.lsp_references()
end, { nowait = true, desc = "References" })
map("n", "gri", function()
	snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
map("n", "gy", function()
	snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
map("n", "gO", function()
	snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
map("n", "<leader>wO", function()
	snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })

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
map("n", "<leader>nr", function()
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
map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
map("n", "<leader>st", function()
	snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "BUG", "ISSUE" } })
end, { desc = "Todo/Fix/Fixme" })

local prettier = { "prettierd", "prettier", stop_after_first = true }
local biome_prettier = { "biome", "prettierd", "prettier", stop_after_first = true }
local conform = require("conform")
conform.setup({
	formatters = {
		biome = {
			require_cwd = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		-- rust-analyzer uses rustfmt under the hood
		-- leptosfmt also needs to use rust-analyzer directly
		-- rust = { "rustfmt" },
		go = { "goimports" },
		python = { "black" },
		toml = { "taplo" },
		json = biome_prettier,
		markdown = prettier,

		-- Web
		html = biome_prettier,
		css = biome_prettier,

		-- JS/TS
		javascript = biome_prettier,
		typescript = biome_prettier,
		typescriptreact = biome_prettier,
		javascriptreact = biome_prettier,
		svelte = prettier,

		-- SQL
		sql = { "sqruff" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})
map("n", "<leader>F", function()
	conform.format({ lsp_format = "fallback" })
end, {
	silent = true,
	noremap = true,
	desc = "[F]ormat buffer",
})
