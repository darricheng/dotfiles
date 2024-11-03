local prettier = { { "prettierd", "prettier" } }

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		javascript = prettier,
		typescript = prettier,
		typescriptreact = prettier,
		javascriptreact = prettier,
		svelte = prettier,
		html = prettier,
		css = prettier,
		json = prettier,
		markdown = prettier,
		rust = { "rustfmt" },
		go = { "goimports" },
		python = { "black" },
		handlebars = { "djlint" },
		toml = { "taplo" },
		php = { "php_cs_fixer" },
		htmldjango = { "djlint" },
		elixir = { "mix" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})

vim.keymap.set("n", "<leader>f", require("conform").format, { silent = true, noremap = true, desc = "[F]ormat buffer" })
