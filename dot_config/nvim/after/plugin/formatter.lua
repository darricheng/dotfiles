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
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf, lsp_fallback = true })
	end,
})

vim.keymap.set("n", "<leader>f", require("conform").format, { silent = true, noremap = true, desc = "[F]ormat buffer" })
