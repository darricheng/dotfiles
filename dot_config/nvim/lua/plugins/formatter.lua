local prettier = { "prettierd", "prettier", stop_after_first = true }
local mix = { "mix", timeout_ms = 2500 }

return {
	{
		"stevearc/conform.nvim",
		opts = {
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
				json = prettier,
				markdown = prettier,

				-- Web
				html = prettier,
				css = prettier,

				-- JS/TS
				javascript = prettier,
				typescript = prettier,
				typescriptreact = prettier,
				javascriptreact = prettier,
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
