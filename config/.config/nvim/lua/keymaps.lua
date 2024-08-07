local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Системный буфер обмена shift - Y
map('v', 'S-Y', '"+y', {})

-- Типа 'Нажимает' на ESC при быстром нажатии jj, чтобы не тянутся
map('i', 'jj', '<Esc>', { noremap = true })

-- Стрелочки откл. Использовать hjkl
map('', '<up>', ':echoe "Use k"<CR>', { noremap = true, silent = false })
map('', '<down>', ':echoe "Use j"<CR>', { noremap = true, silent = false })
map('', '<left>', ':echoe "Use h"<CR>', { noremap = true, silent = false })
map('', '<right>', ':echoe "Use l"<CR>', { noremap = true, silent = false })

-- Автоформат + сохранение по CTRL-s , как в нормальном, так и в insert режиме
-- map('', '<C-s>', ':Autoformat<CR>:w<CR>', default_opts)
map('', '<C-s>', ':w<CR>', default_opts)

-- Выход
map('', '<C-q>', ':q<CR>', default_opts)

-- Переключение вкладок с помощью TAB или shift-tab (akinsho/bufferline.nvim)
map('n', '<Tab>', ':BufferLineCycleNext<CR>', default_opts)
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', default_opts)

-- Пролистнуть на страницу вниз / вверх (как в браузерах)
map('n', '<Space>', '<PageDown> zz', default_opts)
map('n', '<C-Space>', '<PageUp> zz', default_opts)

-- " Переводчик рус -> eng
map('v', 't', '<Plug>(VTranslate)', {})

-- fzf
map('', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = false })
map('', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = false })

-- C-/ for commeting current line
map('', '<C-_>', [[<CMD>lua require("Comment.api").toggle_current_blockwise()<CR><down>]],
  { noremap = true, silent = false })

-----------------------------------------------------------
-- Фн. клавиши по F1 .. F12
-----------------------------------------------------------
-- По F1 очищаем последний поиск с подсветкой
map('n', '<F1>', ':nohl<CR>', default_opts)

-- shift + F1 = удалить пустые строки
map('n', '<S-F1>', ':g/^$/d<CR>', default_opts)

-- <F2> для временной вставки из буфера, чтобы отключить авто идент
vim.o.pastetoggle = '<F2>'

-- <F3> открыть дерево папок
map('n', '<F3>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>', default_opts)

-- <F9> перечитать конфигурацию nvim Может не работать, если echo $TERM  xterm-256color
map('n', '<F9>',
  ':so ~/.config/nvim/init.lua<CR>:so ~/.config/nvim/lua/plugins.lua<CR>:so ~/.config/nvim/lua/settings.lua<CR>:so ~/.config/nvim/lua/keymaps.lua<CR>',
  { noremap = true })

-- <S-F3> Открыть всю nvim конфигурацию для редактирования
map('n', '<S-F3>',
  ':e ~/.config/nvim/init.lua<CR>:e ~/.config/nvim/lua/plugins.lua<CR>:e ~/.config/nvim/lua/settings.lua<CR>:e ~/.config/nvim/lua/keymaps.lua<CR>',
  { noremap = true })

-- <F4> Поиск слова под курсором
map('n', '<F4>', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], default_opts)

-- <S-F4> Поиск слова в модальном окошке
map('n', '<S-F4>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], default_opts)

-- <F5> разные вариации нумераций строк, можно переключаться
map('n', '<F5>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', default_opts)
