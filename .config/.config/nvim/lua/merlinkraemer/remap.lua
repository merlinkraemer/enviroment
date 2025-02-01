-- Set leader
vim.g.mapleader = " "

-- Map leader+e to :Ex
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("Ex")
end)
--keeps search in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--copy to system clipboard leader y
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--no Q cmd
vim.keymap.set("n", "Q", "<nop>")


-- C-f opens tmux search
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
