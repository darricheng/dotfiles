return {
	{
		-- Center the editor so that I don't have to constantly be looking to the left of my screen
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
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
			},
		},
		keys = {
			{ -- NoNeckPain can be a bit buggy when more than one window is open,
				-- so this keymap resets the state of the windows by toggling the plugin twice
				"<leader>nr",
				function()
					vim.cmd.NoNeckPain()
					-- calling the function twice b2b didn't work after upgrading nvim to 0.10
					-- would only be equal to calling the fn once
					-- calling the second instance separately in a defer_fn seems to work fine
					vim.defer_fn(function()
						vim.cmd.NoNeckPain()
					end, 100)
				end,
				desc = "[N]oNeckPain: Reset (double toggle)",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{
				"<leader>z",
				"<cmd>ZenMode<cr>",
				desc = "[Z]enMode",
			},
		},
		opts = {
			plugins = {
				tmux = {
					enabled = true,
				},
			},
		},
	},
	-- Add indentation guides on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		event = require("plugins.utils.events").lazy_file,
		main = "ibl",
		opts = {
			-- Setup config for indent_blankline goes here
			-- See :h ibl.setup for more info
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		opts = {},
		event = "VeryLazy",
	},
	-- autopairs
	{
		"windwp/nvim-autopairs",
		opts = {},
	},
	-- auto html tag closing
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"html",
			"markdown",
			"htmldjango",
			"elixir",
			"heex",
		},
		opts = {
			aliases = {
				["heex"] = "html",
			},
		},
	},
	-- more expressive undos
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{
				"<leader>u",
				vim.cmd.UndotreeToggle,
				desc = "[U]ndoTree",
			},
		},
		init = function()
			-- open undotree on the right and diff below
			vim.g.undotree_WindowLayout = 2
			-- width of the undotree window
			vim.g.undotree_SplitWidth = 40
		end,
	},
	-- Highlight TODO comments and stuff
	{
		"folke/todo-comments.nvim",
		event = require("plugins.utils.events").lazy_file,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/snacks.nvim", -- for searching with snacks picker
		},
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{
				"<leader>st",
				function()
					Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
				end,
				desc = "Todo/Fix/Fixme",
			},
		},
	},

	-- deal with surrounds, such as brackets, quotes, etc
	{
		"kylechui/nvim-surround",
		version = "*",
		event = require("plugins.utils.events").lazy_file,
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			-- use non-opacity changing effect so that screen doesn't flicker
			stages = "slide",
			max_width = 80,
			max_height = 24,
			fps = 60,
			render = "wrapped-default",
		},
		keys = {
			{
				"<leader>sn",
				function()
					require("telescope").extensions.notify.notify()
				end,
				desc = "[S]earch [N]otifications",
			},
			{
				"<leader>nd",
				function()
					require("notify").dismiss({
						silent = true,
						pending = true,
					})
				end,
				desc = "[N]otifications [D]ismiss",
			},
		},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
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
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"tpope/vim-abolish",
		cmd = { "Abolish", "Subvert" },
		keys = "cr",
	},
}
