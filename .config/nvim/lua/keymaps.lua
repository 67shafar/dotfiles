local telescope = require('telescope.builtin')

-- Project Keys
vim.keymap.set("n", "<leader>pf", telescope.find_files, {})
vim.keymap.set("n", "<leader>ps", function()
  telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- File History
vim.keymap.set("n", "<leader>fu", vim.cmd.UndotreeToggle)

-- Git Commands
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Package Management (Mason)
vim.keymap.set("n", "<leader>m", vim.cmd.Mason)
