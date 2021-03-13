" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

syntax on                              " syntax highlight

set noerrorbells                       " no sounds

" FINDINGS FILES:
" Seachr down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

"Display all matching files when we tab complete
set wildmenu

"——————————————————— SHOW WHITE SPACE ————————————————————————————————————————
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:» 

" toggle between invisible character by (backslash-L) `\l`
nmap <leader>l :set list!<CR>

"——————————————————— SET TAB STOPS ———————————————————————————————————————————
set tabstop=4 softtabstop=4            " tabs 4 spaces 
set shiftwidth=4                       " arrow over
set expandtab                          " use spaces instead of tab characters
set smartindent

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

"————————————————— SET LINE NUMBERS ——————————————————————————————————————————
set number                             " show line numbers
set relativenumber                     " show relative line numbers
set numberwidth=5                      " width of number column
"————————————————————————————————————————
" toggle relative line number type: \nu
"————————————————————————————————————————
function! ToggleRelativeNumber()
    let &relativenumber = &relativenumber?0:1
    "let &number = &relativenumber? 0:1
endfunction
nnoremap <silent> <Leader>nu :call ToggleRelativeNumber()<cr>
"————————————————————————————————————————
" Toggle line numbers from none at all
" to relative numbering with current line number
noremap <F6> :set invnumber invrelativenumber<CR>

"—————————————————————————————————————————————————————————————————————————————
set nowrap
set smartcase                          " case sensitive searching
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set colorcolumn=80
set ruler                              " show the cursor position all the time
set hlsearch                           " search highlighting
set showmode                           " Show current mode

call plug#begin('~/.vim/plugged')      " Make sure you use single quotes
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
call plug#end()                        " Initialize plugin system

colorscheme gruvbox
set background=dark

setlocal spell spelllang=pl,en_us      " PL EN Spellchecker

"command `Wrap` will wrap text to the width of screen.
command! -nargs=* Wrap set wrap linebreak

"———— Insert/Delete Blank Line in Normal Mode—————————————————————————————————

" README:
" How to Map `j` `k` with <Alt> on MAC?
" In terminal type Ctrl+V and then Alt+J it will print something. eg.: `∆`  
" or in Vim in `INSERT` mode type Alt-J it will print the same."
" My keyboard <A-j>==∆ and <A-k>==Ż

" Alt-j/k inserts blank line below/above.
nnoremap <silent>∆ :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>Ż :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Ctrl-j/k deletes blank line below/above.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

"————Print ———————————————————————————————————————————————————————————————————
" F2 Print Shebang
:map <F2> i#!/usr/bin/env bash<ESC>2o<ESC>

" F3 Print today date
:map <F3> i# <ESC>:r!date "+\%F \%H:\%M, \%a" <ESC>kJo<ESC>

" F4 Print Created on:
:map <F4> i# Created on: <ESC>:r!LANG=en_US date "+\%a, \%e \%b \%Y, \%H:\%M" <ESC>kJo<ESC>
