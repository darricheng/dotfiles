vim.api.nvim_create_user_command("GC", function()
	vim.cmd([[G commit -v]])
end, {
	desc = "Git commit verbose",
})
