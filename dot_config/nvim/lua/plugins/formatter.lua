local prettier = { "prettierd", "prettier", stop_after_first = true }
local biome_prettier = { "biome", "prettierd", "prettier", stop_after_first = true }

local mix = { "mix", timeout_ms = 2500 }

return {
	{
		"stevearc/conform.nvim",
		opts = {
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
				php = { "php_cs_fixer" },
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

				-- templating languages
				htmldjango = { "djlint" },
				handlebars = { "djlint" },

				-- Elixir
				elixir = mix,
				eelixir = mix,
				heex = mix,
				surface = mix,
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		},
		event = require("plugins.utils.events").lazy_file,
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ lsp_format = "fallback" })
				end,
				silent = true,
				noremap = true,
				desc = "[F]ormat buffer",
			},
		},
	},
}
