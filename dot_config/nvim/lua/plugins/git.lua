return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gwrite" },
	},
	"tpope/vim-rhubarb",
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	},
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
				vim.keymap.set(
					"n",
					"<leader>gd",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "[G]it [D]iff" }
				)
			end,
			preview_config = {
				border = "rounded",
			},
		},
	},

	{
		"polarmutex/git-worktree.nvim",
		version = "^2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local Hooks = require("git-worktree.hooks")
			local config = require("git-worktree.config")
			local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

			Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
				vim.notify("Moved from " .. prev_path .. " to " .. path)
				update_on_switch(path, prev_path)
			end)

			Hooks.register(Hooks.type.DELETE, function()
				vim.cmd(config.update_on_change_command)
			end)
		end,
	},
}
