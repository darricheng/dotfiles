return {
	{ -- debug.lua
		--
		-- Shows how to use the DAP plugin to debug your code.
		"mfussenegger/nvim-dap",
		-- NOTE: And you can specify dependencies as well
		dependencies = {
			-- Creates a beautiful debugger UI
			-- TODO: clean up these deps
			-- e.g. probably can remove or shift the mason deps
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			"leoluz/nvim-dap-go",
		},
		event = "VeryLazy",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local utils = require("dap.utils")

			-- set logging levels to debug why adapters are not working
			-- logs are saved in ~.cache/nvim/dap.log
			dap.set_log_level("DEBUG")

			-- Maybe set this up with mason-nvim-dap handlers?
			dap.adapters = {
				["pwa-node"] = {
					type = "server",
					host = "::1",
					port = "${port}",
					executable = {
						command = "js-debug-adapter",
						args = {
							"${port}",
						},
					},
				},
				["codelldb"] = {
					type = "server",
					port = "${port}",
					executable = {
						-- command = 'codelldb',
						command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
						args = { "--port", "${port}" },
					},
				},
			}

			for _, language in ipairs({ "typescript", "javascript" }) do
				-- js-debug-adapter options:
				-- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to process ID",
						processId = utils.pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Local NestJS (port 9229)",
						address = "localhost",
						port = 9229,
						cwd = "${workspaceFolder}",
						restart = true,
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "ZTO - Dockerised NestJS (port 9229)",
						address = "localhost",
						port = 9229,
						localRoot = "${workspaceFolder}",
						remoteRoot = "usr/src/app",
						-- resolveSourceMapLocations = { '${workspaceFolder}/dist', '!**/node_modules/**' },
						restart = true,
					},
				}
			end

			dap.configurations.rust = {
				{
					type = "codelldb",
					request = "launch",
					name = "Launch file",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			}

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			-- TODO: set up dapui with neodev (see: https://github.com/rcarriga/nvim-dap-ui#installation)
			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			local map = function(keys, func, desc)
				if desc then
					desc = "De[B]ugger: " .. desc
				end
				if keys then
					keys = "<leader>b" .. keys
				end
				vim.keymap.set("n", keys, func, { desc = desc })
			end

			-- Basic debugging keymaps, feel free to change to your liking!
			map("s", dap.continue, "[S]tart/Continue")
			map("i", dap.step_into, "Step [I]nto")
			map("v", dap.step_over, "Step O[V]er")
			map("o", dap.step_out, "Step [O]ut")
			map("b", dap.toggle_breakpoint, "Toggle [B]reakpoint")
			map("B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, "Set [B]reakpoint")

			-- dap-ui
			map("u", function()
				dapui.toggle({
					-- Always open the nvim dap ui in the default sizes
					reset = true,
				})
			end, "Toggle [U]I")
		end,
	},
}
