return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use 'joshdick/onedark.vim'

  -- External Tools Manager
  use {
    "williamboman/mason.nvim",
    -- :MasonUpdate updates registry contents
    run = ":MasonUpdate"
  }

  -- configuration for default lsp clinet of nvim
  use 'neovim/nvim-lspconfig'

  -- connects mason with lspconfig
  use "williamboman/mason-lspconfig.nvim"

  --  completion engine plugin for neovim written in Lua.
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  --  fzf
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }

  -- Code - file support
  use 'zigford/vim-powershell'
  use 'cespare/vim-toml'
  use 'editorconfig/editorconfig-vim'
  use 'gabrielelana/vim-markdown'
  use 'numToStr/Comment.nvim'

  -- buffer
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- status bar like tmux
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  -- git plugin
  use 'tpope/vim-fugitive'

  -- автоформатирование
  -- python3 -m pip install pynvim
  use 'vim-autoformat/vim-autoformat'

  -- Подсвечивает #ffffff
  use 'ap/vim-css-color'

  -- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
  use 'idanarye/breeze.vim'

  -- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
  use 'alvan/vim-closetag'

  -- editorconfig настройки
  use 'gpanders/editorconfig.nvim'
end)
