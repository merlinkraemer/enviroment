return {
  -- Gruvbox colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Your existing function can be used here
      local function ColorMyPencils(color)
        color = color or "gruvbox"
        vim.cmd.colorscheme(color)
      end
      
      -- Call the function
      ColorMyPencils()
    end,
  },
}

