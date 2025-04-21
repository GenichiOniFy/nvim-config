return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.adapters.coreclr = {
            type = 'executable',
            command = 'netcoredbg',
            args = {'--interpreter=vscode'}
        }

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
            },
        }

        dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

        local continue = function()
			-- support for vscode launch.json is partial.
			-- not all configuration options and features supported
			if vim.fn.filereadable(".vscode/launch.json") then
				require("dap.ext.vscode").load_launchjs()
			end
			dap.continue()
		end

        vim.keymap.set('n','<F2>', dap.toggle_breakpoint, { desc = "Toggle breakpoint"})
        vim.keymap.set('n','<F9>', continue, { desc = "Continue"})
        vim.keymap.set('n','<F10>', dap.step_over, { desc = "Step over"})
        vim.keymap.set('n','<F11>', dap.step_into, { desc = "Step into"})
        vim.keymap.set('n','<F12>', dap.step_out, { desc = "Step out"})
    end
}
