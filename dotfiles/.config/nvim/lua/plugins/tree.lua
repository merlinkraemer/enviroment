return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
                side = "right",
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        folder_arrow = true,
                        git = false,
                    },
                },
            },
            filters = {
                dotfiles = true,
            },
        }
    end,
}
