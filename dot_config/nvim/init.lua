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

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",

	-- general
	"https://github.com/folke/snacks.nvim",
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",

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

	-- git
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/lewis6991/gitsigns.nvim",

	-- quickfix
	"https://github.com/stevearc/quicker.nvim",

	-- treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",

	-- lsp
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/aerial.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/Bilal2453/luvit-meta",
	"https://github.com/j-hui/fidget.nvim",
})

vim.cmd.colorscheme("catppuccin-mocha")

require("lualine").setup({
	options = {
		component_separators = "|",
		section_separators = "",
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
-- Adapted from: https://github.com/xaaha/dev-env/blob/d83b718fa2372704b993c4e0c8338e460d44a3d5/nvim/.config/nvim/init.lua#L276
-- See reddit thread: https://www.reddit.com/r/neovim/comments/1l3z4j4/help_with_new_treesitter_setup_in_neovim_default/
local ts_ensure_installed = {
	"c",
	"cpp",
	"go",
	"lua",
	"rust",
	"tsx",
	"typescript",
	"javascript",
	"svelte",
	"vimdoc",
	"markdown",
	"markdown_inline",
	"json",
	"toml",
	"regex",
	"bash",
	"css",
	"just",
	"fish",
}
-- Install parsers and register them for filetypes
require("nvim-treesitter").install(ts_ensure_installed)
for _, parser in ipairs(ts_ensure_installed) do
	vim.treesitter.language.register(parser, parser)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = parser,
		callback = function(event)
			vim.treesitter.start(event.buf, parser)
		end,
	})
end
-- Auto-install and start parsers for any buffer not in the list above
vim.api.nvim_create_autocmd("BufRead", {
	callback = function(event)
		local bufnr = event.buf
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

		if filetype == "" then
			return
		end

		-- Skip if already handled by ts_ensure_installed
		if vim.tbl_contains(ts_ensure_installed, filetype) then
			return
		end

		local parser_name = vim.treesitter.language.get_lang(filetype)
		if not parser_name then
			return
		end

		local parser_configs = require("nvim-treesitter.parsers")
		if not parser_configs[parser_name] then
			return
		end

		local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

		if not parser_installed then
			require("nvim-treesitter").install({ parser_name }):wait(30000)
		end

		parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

		if parser_installed then
			vim.treesitter.start(bufnr, parser_name)
		end
	end,
})

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
		-- Run TSUpdate when treesitter is updated
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
		if name == "LuaSnip" and (kind == "install" or kind == "update") then
			-- TODO: Figure out how to auto run the make command that is required
			vim.notify(vim.inspect(ev))
		end
	end,
})
