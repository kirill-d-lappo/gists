local cmd = vim.cmd            -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g                -- global variables
local opt = vim.opt            -- global/buffer/windows-scoped options

-- Main

-- линейка
opt.colorcolumn = '80,120,140'

-- Подсветка строки с курсором
opt.cursorline = true

-- Словари рус eng
opt.spelllang = { 'en_us', 'ru' }

-- Включаем нумерацию строк
opt.number = true

-- Вкл. относительную нумерацию строк
opt.relativenumber = true

-- Курсор всегда в центре экрана
opt.scrolloff = 1920

-- Возможность отката назад
opt.undofile = true

-- vertical split вправо
opt.splitright = true

-- horizontal split внизs
opt.splitbelow = true

--  24-bit RGB colors
opt.termguicolors = true
cmd 'colorscheme onedark'

-- Tabs
-- use spaces instead of tabs
opt.expandtab = false

-- shift 4 spaces when tab
opt.shiftwidth = 2

-- 1 tab == 4 spaces
opt.tabstop = 2

-- autoindent new lines
opt.smartindent = true

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400}
augroup end
]], false)


-- плагины

-- включается мэйсон, коннектится с лсп конфигами
require("mason").setup()
require("mason-lspconfig").setup()

require 'telescope'.setup {}

require('Comment').setup {}

require("bufferline").setup {}

require('lualine').setup()


local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
    { name = 'buffer' },
  })
})


-- конфигурим лсп
local lspconfig = require('lspconfig')

local servers = {
  'ruff_lsp',
  'omnisharp'
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end
