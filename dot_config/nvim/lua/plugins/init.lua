return {
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

	-- For easier access of those few frequently accessed files
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Harpoon: Mark file of current buffer",
			},
			{
				"<leader>hh",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Harpoon: Open list of marked files",
			},
		},
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
			confirmation = {
				border = "rounded",
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
	},
}
