return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "omnisharp", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hoffs/omnisharp-extended-lsp.nvim",
		},
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				cmd = { "omnisharp" },
				settings = {
					FormattingOptions = {
						EnableEditorConfigSupport = true,
						OrganizeImports = true,
					},
					Sdk = {
						IncludePrereleases = true,
					},
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local omnisharp_extended = require("omnisharp_extended")
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client.name == "omnisharp" then
						vim.keymap.set(
							"n",
							"gr",
							omnisharp_extended.telescope_lsp_references,
							{ desc = "Go to references", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"gd",
							omnisharp_extended.telescope_lsp_definition,
							{ desc = "Go to difinition", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"gD",
							omnisharp_extended.telescope_lsp_type_definition,
							{ desc = "Go to type difinition", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"gi",
							omnisharp_extended.telescope_lsp_implementation,
							{ desc = "Go to implementations", buffer = ev.buf }
						)
					else
						vim.keymap.set(
							"n",
							"gd",
							vim.lsp.buf.definition,
							{ desc = "Go to type difinition", buffer = ev.buf }
						)
					end
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Display information" })
					vim.keymap.set({ "n", "v" }, "<C-a>", vim.lsp.buf.code_action, {})
				end,
			})
		end,
	},
}
