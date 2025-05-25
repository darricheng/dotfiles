return {
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "junegunn/seoul256.vim", lazy = true },
	{
		"loctvl842/monokai-pro.nvim",
		-- The below options are for setting monokai-pro as the default colorscheme
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			require("monokai-pro").setup({
				-- NOTE: this doesn't seem to be working yet
				background_clear = { "float_win" },
			})
			vim.cmd([[colorscheme monokai-pro]])
		end,
	},
}
