return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            --[transparent_background = true,
            integration = {
                neotree = true,
                telescope = {
                    enabled = true,
                    -- style = "nvchad"
                },
                treesitter = true,
            },
        })
        vim.cmd.colorscheme("catppuccin")
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        })
    end,
}
