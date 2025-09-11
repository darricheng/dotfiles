local lsp = vim.lsp

-- Need to manually enable RA because it's the only one not installed by Mason.
lsp.enable("rust_analyzer")

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

-- vim.api.nvim_create_user_command("LspRestart", function()
-- 	local clients = vim.lsp.get_clients()
--
-- 	-- #foo gets the length of the table elements that don't have keys
-- 	if #clients < 1 then
-- 		vim.notify("No clients to restart", vim.log.levels.WARN)
-- 		return
-- 	end
--
-- 	local clients_list = ""
--
-- 	---disable the lint of the unused variable i
-- 	---@diagnostic disable-next-line: unused-local
-- 	for i, client in ipairs(clients) do
-- 		clients_list = clients_list .. "- " .. client.name .. "\n"
-- 	end
--
-- 	-- Space between \n needed, otherwise they collapse into a single line break
-- 	vim.notify("Restarting clients:\n \n" .. clients_list, vim.log.levels.INFO)
--
-- 	-- :h lsp-faq
-- 	lsp.stop_client(clients)
-- 	vim.defer_fn(function()
-- 		vim.cmd("edit")
-- 	end, 500) -- timeout needed otherwise LSP doesn't seem to restart
-- end, {
-- 	desc = "Restart attached LSPs",
-- 	force = true, -- to replace the command from lspconfig
-- })
