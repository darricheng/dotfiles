require("config.highlight")
require("config.remap")
require("config.set")

---@param modes string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
local map = function(modes, lhs, rhs, opts)
	vim.keymap.set(modes, lhs, rhs, opts)
end

---@param repo string           user/repo of the plugin
local gh = function(repo)
	return "https://github.com/" .. repo
end

vim.cmd.packadd("nvim.undotree")
vim.pack.add({
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },

	-- dependencies
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-tree/nvim-web-devicons"),

	-- general
	gh("folke/snacks.nvim"),
	gh("nvim-mini/mini.nvim"),
	gh("tpope/vim-sleuth"),
	gh("nvim-lualine/lualine.nvim"),
	gh("stevearc/oil.nvim"),
	gh("christoomey/vim-tmux-navigator"),

	-- editor stuff
	{ src = gh("shortcuts/no-neck-pain.nvim"), version = vim.version.range("*") },
	gh("tpope/vim-abolish"),
	{ src = gh("kylechui/nvim-surround"), version = vim.version.range("*") },
	gh("numToStr/Comment.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("windwp/nvim-ts-autotag"),
	gh("lukas-reineke/indent-blankline.nvim"),
	gh("folke/todo-comments.nvim"),

	-- Formatting
	gh("stevearc/conform.nvim"),

	-- git
	gh("tpope/vim-fugitive"),
	gh("lewis6991/gitsigns.nvim"),

	-- quickfix
	gh("stevearc/quicker.nvim"),

	-- treesitter
	{
		src = "https://github.com/VonHeikemen/ts-enable.nvim",
		version = "v2.x",
	},
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("nvim-treesitter/nvim-treesitter-context"),

	-- lsp
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("stevearc/aerial.nvim"),
	gh("rafamadriz/friendly-snippets"),
	{ src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") },
	{ src = gh("Saghen/blink.cmp"), version = vim.version.range("1.*") },
	gh("folke/lazydev.nvim"),
	gh("Bilal2453/luvit-meta"),
	gh("j-hui/fidget.nvim"),
})

vim.cmd.colorscheme("catppuccin-mocha")
map("n", "<leader>u", require("undotree").open)

require("lualine").setup({
	options = {
		component_separators = "|",
		section_separators = "",
	},
})

local miniclue = require("mini.clue")
miniclue.setup({
	window = { delay = 1000 },
	triggers = {
		-- Leader triggers
		{ mode = { "n", "x" }, keys = "<Leader>" },
		-- `[` and `]` keys
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },
		-- `g` key
		{ mode = { "n", "x" }, keys = "g" },
		-- Marks
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		-- Registers
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
		-- Window commands
		{ mode = "n", keys = "<C-w>" },
		-- `z` key
		{ mode = { "n", "x" }, keys = "z" },
		-- other keys
		{ mode = { "n", "x" }, keys = "d" },
	},
	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	columns = {
		"icon",
		"permissions",
		-- "mtime",
		-- "size",
	},
	view_options = {
		show_hidden = true,
	},
	win_options = {
		winbar = "%{v:lua.require('oil').get_current_dir()}",
	},
	use_default_keymaps = false,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-v>"] = "actions.select_vsplit",
		["<C-x>"] = "actions.select_split",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-r>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
		["C-t"] = false, -- don't need new tab
		["C-l"] = false, -- so that tmux navigator works
		["C-h"] = false, -- so that tmux navigator works
	},
	confirmation = {
		border = "rounded",
	},
})

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
require("nvim-ts-autotag").setup()

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

local conform = require("conform")
local web_fmt = { "oxfmt" }
conform.setup({
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
		json = web_fmt,
		markdown = web_fmt,
		html = web_fmt,
		css = web_fmt,
		javascript = web_fmt,
		typescript = web_fmt,
		typescriptreact = web_fmt,
		javascriptreact = web_fmt,
		svelte = web_fmt,
		sql = { "sqruff" },
		typst = { "typstyle" },
		fish = { "fish_indent" },
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

require("gitsigns").setup({
	-- See `:help gitsigns.txt`
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		-- goto prev hunk
		vim.keymap.set("n", "[c", function()
			gitsigns.nav_hunk("prev")
		end, { buffer = bufnr, desc = "Go to Previous Hunk" })

		-- goto next hunk
		vim.keymap.set("n", "]c", function()
			gitsigns.nav_hunk("next")
		end, { buffer = bufnr, desc = "Go to Next Hunk" })

		-- view git diff
		vim.keymap.set("n", "<leader>gd", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "[G]it [D]iff" })
	end,
	preview_config = {
		border = "rounded",
	},
})

local quicker = require("quicker")
quicker.setup({
	keys = {
		{
			">",
			function()
				quicker.expand({ before = 2, after = 2, add_to_existing = true })
			end,
			desc = "Expand quickfix context",
		},
		{
			"<",
			function()
				quicker.collapse()
			end,
			desc = "Collapse quickfix context",
		},
	},
})
map("n", "<leader>q", function()
	quicker.toggle()
end, { desc = "Toggle quickfix" })
map("n", "<leader>l", function()
	quicker.toggle({ loclist = true })
end, { desc = "Toggle loclist" })

-- vim-tmux-navigator
map("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>")
map("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>")
map("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>")
map("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>")
map("n", "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>")

-- treesitter
-- ts-enable options
vim.g.ts_enable = {
	auto_init = false,
	auto_install = true,
	highlights = true,
}

-- nvim-treesitter-textobjects
require("nvim-treesitter-textobjects").setup()
vim.keymap.set({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)

require("treesitter-context").setup({
	-- Make context always show for top-most code block
	-- Other alternative is 'cursor', where context only shows if my cursor is in that top-most code block
	mode = "cursor",
})
vim.api.nvim_create_user_command("TSPlayground", function()
	vim.notify("Use the builtin InspectTree cmd")
end, {})

-- lsp
require("mason").setup()
require("mason-lspconfig").setup()
require("aerial").setup()
require("fidget").setup({})
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-n>"] = { "select_next", "fallback_to_mappings" },
		["<C-j>"] = { "select_next", "fallback_to_mappings" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-k>"] = { "select_prev", "fallback_to_mappings" },
		["<C-y>"] = { "select_and_accept", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
	},
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		per_filetype = {
			lua = { inherit_defaults = true, "lazydev" },
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
		},
	},
	completion = {
		ghost_text = {
			enabled = false,
			show_with_selection = false,
			show_without_selection = false,
			show_with_menu = false,
			show_without_menu = false,
		},
		list = {
			selection = {
				auto_insert = false,
			},
		},
	},
})
require("lazydev").setup({
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if name == "LuaSnip" and (kind == "install" or kind == "update") then
			-- TODO: Figure out how to auto run the make command that is required
			vim.notify(vim.inspect(ev))
		end
	end,
})
