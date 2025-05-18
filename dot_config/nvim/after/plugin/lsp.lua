local lsp = vim.lsp
local tele = require("telescope.builtin")

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
		map("n", "gd", tele.lsp_definitions, "[G]oto [D]efinition")
		map("n", "go", tele.lsp_type_definitions, "[G]oto Type Definition")
		map("n", "gD", lsp.buf.declaration, "[G]oto [D]eclaration")
		map("n", "gs", lsp.buf.signature_help, "[G]oto [S]ignature")

		-- overwrites the neovim defaults
		map("n", "gri", tele.lsp_implementations, "[G]oto [I]mplementation")
		map("n", "grr", tele.lsp_references, "[G]oto [R]eferences")

		-- These have neovim defaults now
		-- grr
		-- map("n", "<leader>rn", lsp.buf.rename, "[R]e[N]ame")
		-- gra
		-- map("n", "<leader>ca", lsp.buf.code_action, "[C]ode [A]ction")

		-- File navigation
		map("n", "<leader>o", "<cmd>AerialToggle!<cr>", "[O]utline")

		-- Diagnostics
		map("n", "gl", vim.diagnostic.open_float, "Open diagnostic float")
		map("n", "]d", vim.diagnostic.get_next, "Jump to the next diagnostic")
		map("n", "[d", vim.diagnostic.get_prev, "Jump to the previous diagnostic")

		-- search symbols
		map("n", "<leader>Sd", require("telescope.builtin").lsp_document_symbols, "[S]ymbols: [D]ocument")
		map("n", "<leader>Sw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[S]ymbols: [W]orkspace")

		-- Lesser used LSP functionality
		map("n", "<leader>wa", lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		map("n", "<leader>wr", lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		map("n", "<leader>wl", function()
			print(vim.inspect(lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")
	end,
})
