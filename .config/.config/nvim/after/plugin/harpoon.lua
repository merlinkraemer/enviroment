local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Add a file to Harpoon
vim.keymap.set("n", "<leader>a", mark.add_file)

-- Toggle the Harpoon quick menu with <leader>h
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)

-- Map <leader>1 to <leader>4 to navigate to specific files
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)

