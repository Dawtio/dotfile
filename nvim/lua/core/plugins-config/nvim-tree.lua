vim.g.loaded_netrw = 1
vim.g.loaded_netwrPlugin = 1

require('nvim-tree').setup()

vim.keymap.set('n', '<c-g>', ':NvimTreeFindFileToggle<CR>')
