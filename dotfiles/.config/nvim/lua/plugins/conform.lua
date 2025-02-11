return

{
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
    -- This will help ensure formatters are installed
    init = function()
        -- If you want to format on save
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
