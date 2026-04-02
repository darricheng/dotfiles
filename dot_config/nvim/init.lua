require("config")
require("config.remap")
require("config.set")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

vim.cmd.colorscheme("catppuccin-macchiato")
