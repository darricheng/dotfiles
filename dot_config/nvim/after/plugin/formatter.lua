local prettier = { { "prettierd", "prettier" } }

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		rust = { "rustfmt" },
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
		elixir = { "mix" },
		eelixir = { "mix" },
		heex = { "mix" },
		surface = { "mix" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})

vim.keymap.set("n", "<leader>f", require("conform").format, { silent = true, noremap = true, desc = "[F]ormat buffer" })
