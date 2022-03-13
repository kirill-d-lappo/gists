" Kirill Lappo<kirill-lappo@outlook.com>
" Based on: [Delaem is VIMa konfetku](https://habr.com/ru/post/468265/)

" Verified on: Vim 8.2 (Debian, Windows)

" $HOME variable is used to support VIM for Windows
" Better use gVim on Windows, cmd and powershell options are freaking bad

let $BUNLDEROOT = $HOME.'/.vim/bundle'
let $VUNDLEROOT = $BUNLDEROOT.'/Vundle.vim'

" Windows-related hacks
if has('win32')
"   For some fucking reason Vim for Windows will not correctly call git.exe
"   or any other binary, need to specify cmd.exe as a shell
    let &shell='cmd.exe'

"   Only for grafical usage
"   :help feature-list:
    if has('gui_running')
        if has("gui_win32")
"           My favorite font for gVim on Windows
"           I set it up in gVim and then get the value typing vim command
"           :set guifont?
            set guifont=Cascadia\ Mono\ PL:h13:cRUSSIAN:qDRAFT
        endif
    endif
endif

" Install Vundle when it is not installed
if empty(glob($VUNDLEROOT))
    execute 'silent !git clone https://github.com/VundleVim/Vundle.vim.git '$VUNDLEROOT
endif

"   Otherwise Vundle functions will not be available here
set rtp+=$VUNDLEROOT

" Have to specify bundle folder path to support Windows
call vundle#begin($BUNLDEROOT)

Plugin 'VundleVim/Vundle.vim'                   " Required by Vundle

" Beautify shit
Plugin 'joshdick/onedark.vim'                   " Color scheme
Plugin 'vim-airline/vim-airline'                " Status bar, tmux edition
Plugin 'tpope/vim-fugitive'                     " Git plugin

" Functional shit
Plugin 'preservim/nerdtree'                     " File Xplorer

" Code
Plugin 'tpope/vim-dispatch'                     " Dependency for some other plugins
Plugin 'Shougo/vimproc.vim'                     " file search. I think. =)
Plugin 'ctrlpvim/ctrlp.vim'                     " definitly awesome file search. CTRL+P

" Code - file support
Plugin 'zigford/vim-powershell'
Plugin 'cespare/vim-toml'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'gabrielelana/vim-markdown'

" Well, it's not perfect but I don't want to recheck all my plugins on startup
" It can be done on a clean install once, and it is fine for me
if empty(glob('$BUNLDEROOT/onedark.vim'))
    PluginInstall
    exec "q"
endif

call vundle#end()

" Vim basic
set nocompatible                    " be iMproved, required by Vundle
filetype off                        " required by Vundle
syntax on
filetype plugin indent on
colorscheme onedark
set number relativenumber           " Line relative numbers
set wrap linebreak nolist           " Word-wraping
set cursorline
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" vim-airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#keymap#enabled = 0
let g:airline_section_z = "%c:%l/%L"
let g:Powerline_symbols='utf-8'
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=0

" Key bindings
" let mapleader=","
nnoremap <special> <F3> :NERDTreeToggle<CR>

" Cyrillic input fix - no need to switch between keyboard layouts (EN/RU)
" Switch layout inside of vim - CTRL+^
" Details : Vim и кириллица: парочка приёмов [https://habr.com/ru/post/98393/]
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" File Type Settings

" Yaml intendation
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab