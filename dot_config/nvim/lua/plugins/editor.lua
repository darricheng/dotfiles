return {
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
					Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "BUG", "ISSUE" } })
				end,
				desc = "Todo/Fix/Fixme",
			},
		},
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
				"<leader>nd",
				function()
					vim.notify("Use <leader>Dn instead", vim.log.levels.WARN)
				end,
				desc = "(DEPRECATED) [N]otifications [D]ismiss",
			},
			{
				"<leader>Dn",
				function()
					require("notify").dismiss({
						silent = true,
						pending = true,
					})
				end,
				desc = "[D]ismiss [N]otifications",
			},
		},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"folke/snacks.nvim", -- for searching with snacks picker
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
		keys = {
			{
				"<leader>fm",
				function()
					vim.cmd([[Noice pick]])
				end,
				desc = "Find Messages",
			},
		},
	},
}
