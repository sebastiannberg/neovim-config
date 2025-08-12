-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open a small terminal with <leader>st
vim.keymap.set('n', '<leader>st', function()
  vim.cmd 'belowright 10split | term'
  vim.cmd 'startinsert'
end, { desc = 'Open a small terminal' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- NOTE: This won't work in all terminal emulators/tmux/etc.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move lines up or down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
