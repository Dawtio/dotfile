-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

--- TODO comment
vim.keymap.set("n", "<c-i>", ":TodoTelescope<CR>")

--- toggleterm
vim.keymap.set("i", [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm"<CR>')
vim.keymap.set("n", [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm"<CR>')
function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C=\><C-n><C-W>k]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

--- nvimtree
vim.keymap.set("n", "<leader>n", ":NvimTreeClose<CR>")
vim.keymap.set("n", "<c-n>", ":NvimTreeFindFile<CR>")

--- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<c-p>", builtin.find_files, {})
vim.keymap.set("n", "<Space><Space>", builtin.oldfiles, {})
vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})

--- vim-test
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
