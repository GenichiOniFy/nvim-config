return {
	"nvim-neotest/neotest",
	dependencies = {
		"antoinemadec/FixCursorHold.nvim",
		"Issafalcon/neotest-dotnet",
	},

	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-dotnet")({
					dap = { adapter_name = "coreclr" },
					discovery_root = "solution",
				}),
			},
		})

		vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run tests in file" })
		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Debug nearest test" })
		vim.keymap.set("n", "<leader>ts", neotest.run.stop, { desc = "Stop nearest test" })
		vim.keymap.set("n", "<leader>tw", neotest.watch.toggle, { desc = "Watch tests" })
		vim.keymap.set("n", "<C-t>", neotest.summary.toggle, { desc = "Open test explorer" })
		vim.keymap.set("n", "<leader>trm", neotest.summary.run_marked, { desc = "Run marked tests" })
		vim.keymap.set("n", "<leader>tcm", neotest.summary.clear_marked, { desc = "Clear marked tests" })
		vim.keymap.set("n", "<leader>to", neotest.output.open, { desc = "Open test output" })
		vim.keymap.set("n", "<leader>top", neotest.output_panel.toggle, { desc = "Open test output" })
	end,
}
