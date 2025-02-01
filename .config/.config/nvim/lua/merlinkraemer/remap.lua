-- Set leader
vim.g.mapleader = " "

-- Map leader+e to :Ex
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("Ex")
end)

