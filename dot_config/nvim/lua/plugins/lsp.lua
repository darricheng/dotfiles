return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = true,
		opts = {},
	},
	{ "williamboman/mason-lspconfig.nvim" },

	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
	},
	"neovim/nvim-lspconfig",
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		config = true,
	},

	-- Autocompletion
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
		},
		opts = function()
			local cmp = require("cmp")

			local function select_next()
				if cmp.visible() then
					cmp.select_next_item({ behavior = "select" })
				else
					cmp.complete()
				end
			end
			local function select_prev()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = "select" })
				else
					cmp.complete()
				end
			end

			local ret = {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping(select_next),
					["<C-j>"] = cmp.mapping(select_next),
					["<C-p>"] = cmp.mapping(select_prev),
					["<C-k>"] = cmp.mapping(select_prev),
					["<C-y>"] = cmp.mapping.confirm({
						-- selects the first item if none are selected
						select = true,
					}),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
				-- makes the windows bordered so that they clearly float on top of the editor
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- show the source that created the completion item
				-- copied from lsp_zero
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, item)
						local n = entry.source.name
						local label = ""

						if n == "nvim_lsp" then
							label = "[LSP]"
						elseif n == "nvim_lua" then
							label = "[nvim]"
						else
							label = string.format("[%s]", n)
						end

						if item.menu ~= nil then
							item.menu = string.format("%s %s", label, item.menu)
						else
							item.menu = label
						end

						return item
					end,
				},
				filetype = {
					sql = {
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					},
				},
			}

			return ret
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	"rafamadriz/friendly-snippets",

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
