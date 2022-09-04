vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	use 'joshdick/onedark.vim'		-- colorscheme

	-- status bar like tmux
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			require('lualine').setup()
		end,
	}

	use 'tpope/vim-fugitive'			-- git plugin

	use {
		'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end, 
	}
	use 'Xuyuanp/nerdtree-git-plugin'
	use 'ryanoasis/vim-devicons'
	use 'tiagofumo/vim-nerdtree-syntax-highlight'

	-- buffer
	use {
		'akinsho/bufferline.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require("bufferline").setup{}
		end,
	}

	-- Навигация внутри файла по классам и функциям
	use 'majutsushi/tagbar'

	-- Замена fzf и ack
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} },
		config = function()
			require'telescope'.setup {}
		end,
	}

	-- External Tools Manager
	use "williamboman/mason.nvim"
	
	-- Code -- lsp
	use 'neovim/nvim-lsp-installer'
	--	use 'neovim/nvim-lspconfig'

	-- Code - file support
	use 'zigford/vim-powershell'
	use 'cespare/vim-toml'
	use 'editorconfig/editorconfig-vim'
	use 'gabrielelana/vim-markdown'
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup{}
		end,
	}

	-- Codw -- Highlight, edit, and navigate code using a fast incremental parsing library
	use 'nvim-treesitter/nvim-treesitter'

	-- Code -- autocompletion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'saadparwaiz1/cmp_luasnip'

	--- Автодополнлялка к файловой системе
	use 'hrsh7th/cmp-path'

	-----------------------------------------------------------
	-- HTML и CSS
	-----------------------------------------------------------
	-- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
	use 'idanarye/breeze.vim'
	-- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
	use 'alvan/vim-closetag'
	-- Подсвечивает #ffffff
	use 'ap/vim-css-color'

	use 'Chiel92/vim-autoformat'

	-- ]p - вставить на строку выше, [p - ниже
	use 'tpope/vim-unimpaired'

	--- popup окошки
	use 'nvim-lua/popup.nvim'

	-- Закрывает автоматом скобки
	use 'cohama/lexima.vim'
	-- Линтер, работает для всех языков
	use 'dense-analysis/ale'

	-- Todo [2022/03/12 KL] Add here check if plugins are installed and then install

end)
