local cmd = vim.cmd            -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g                -- global variables
local opt = vim.opt            -- global/buffer/windows-scoped options

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

g.mapleader = " "              -- Space as <leader>

-- Типа 'Нажимает' на ESC при быстром нажатии jj, чтобы не тянутся
map('i', 'jj', '<Esc>', { noremap = true })

-- Стрелочки откл. Использовать hjkl
map('', '<up>', ':echoe "Use k"<CR>', { noremap = true, silent = false })
map('', '<down>', ':echoe "Use j"<CR>', { noremap = true, silent = false })
map('', '<left>', ':echoe "Use h"<CR>', { noremap = true, silent = false })
map('', '<right>', ':echoe "Use l"<CR>', { noremap = true, silent = false })

-- remove search highlight
map('n', '<leader>nh', ':nohl<CR>', default_opts)

-- inc/dec numbers
map('n', '<leader>+', '<C-a>', default_opts)
map('n', '<leader>-', '<C-x>', default_opts)

-- splits
map('n', '<leader>sv', '<C-w>v', default_opts)               -- split vertically
map('n', '<leader>sh', '<C-w>s', default_opts)               -- split horizontally
map('n', '<leader>se', '<C-w>=', default_opts)               -- make split equal size
map('n', '<leader>sx', '<CMD>close<CR>', default_opts)       -- close current split


map('n', '<leader>to', '<CMD>tabnew<CR>', default_opts)               -- open new tab
map('n', '<leader>tx', '<CMD>tabclose<CR>', default_opts)             -- close new tab
map('n', '<leader>tn', '<CMD>tabn<CR>', default_opts)                 -- nav to next tab
map('n', '<leader>tp', '<CMD>tabp<CR>', default_opts)                 -- nav to prev tab
map('n', '<leader>tf', '<CMD>tabnew %<CR>', default_opts)             -- open current buffer in a new tab



