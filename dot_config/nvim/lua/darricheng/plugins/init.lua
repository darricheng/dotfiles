return {
	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	},
	-- NOTE: I need to learn more about git worktrees to properly use this plugin
	{ "ThePrimeagen/git-worktree.nvim", event = "VeryLazy" },

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"[c",
					require("gitsigns").prev_hunk,
					{ buffer = bufnr, desc = "Go to Previous Hunk" }
				)
				vim.keymap.set("n", "]c", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Go to Next Hunk" })
				vim.keymap.set(
					"n",
					"<leader>gd",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "[G]it [D]iff" }
				)
			end,
		},
	},
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				component_separators = "|",
				section_separators = "",
			},
		},
	},
	-- Seems to be a dependency for many plugins
	"nvim-lua/plenary.nvim",

	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	-- Treesitter
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-context",
	{
		"nvim-treesitter/playground",
		event = "VeryLazy",
	},
	"RRethy/nvim-treesitter-endwise",

	-- pick out errors easily
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
	},

	-- For easier access of those few frequently accessed files
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
	},
	-- Plain text table creating and formatting, mainly for markdown files
	{
		"dhruvasagar/vim-table-mode",
		ft = "markdown",
		init = function()
			-- Change prefix for table mode plugin shortcuts
			vim.g.table_mode_map_prefix = "<leader>mt"
		end,
	},
	-- Formatting
	-- 'mhartington/formatter.nvim',
	"stevearc/conform.nvim",

	-- preview markdown directly in neovim
	-- install `glow` with `brew install glow` to use this
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
		event = "VeryLazy",
	},
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
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
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Obsidian!
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/darric_second_brain/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/darric_second_brain/**.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter",
		},
	},
}
