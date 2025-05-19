local lsp = vim.lsp

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local map = function(mode, keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		-- Goto keymaps
		map("n", "gD", lsp.buf.declaration, "[G]oto [D]eclaration")
		map("n", "gs", lsp.buf.signature_help, "[G]oto [S]ignature")

		-- File navigation
		map("n", "<leader>o", "<cmd>AerialToggle!<cr>", "[O]utline")

		-- Lesser used LSP functionality
		map("n", "<leader>wa", lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		map("n", "<leader>wr", lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		map("n", "<leader>wl", function()
			print(vim.inspect(lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")
	end,
})
