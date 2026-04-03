return {
	-- Useful status updates for LSP
	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	-- Additional lua configuration, makes nvim stuff amazing!
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	-- optional `vim.uv` typings
	{ "Bilal2453/luvit-meta", lazy = true },
}
