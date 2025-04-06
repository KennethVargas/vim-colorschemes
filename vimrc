" Basic settings
set nocompatible
filetype plugin indent on
syntax on
set number
" set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set hidden " Allow switching buffers without saving

" Plugin manager (Vim-Plug)
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dispatch'
Plug 'preservim/nerdtree'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' "Optional: for themes
call plug#end()

" Install plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" YAML settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml set indentkeys-=<:>

" Python settings
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal omnifunc=python3complete#Complete

" C/C++ settings
autocmd FileType c,cpp setlocal ts=4 sts=4 sw=4 expandtab

" HTML, CSS, PHP settings
autocmd FileType html,css,php setlocal ts=2 sts=2 sw=2 expandtab

" C/C++ Compile and Run (GCC)
autocmd FileType c,cpp nnoremap <F9> :Dispatch g++ -std=c++17 % -o %< -Wall -Wextra -Wpedantic -lstdc++<CR>
autocmd FileType c,cpp nnoremap <F10> :Dispatch ./%<<CR>

" Cppcheck Linter
autocmd FileType c,cpp set makeprg=cppcheck\ %
autocmd FileType c,cpp nnoremap <leader>c :make<CR>

" Netrw settings
let g:netrw_liststyle = 3 " Tree view
let g:netrw_browse_split = 4 " open in vertical split
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_winsize = 25
nnoremap <leader>e :e .<CR>

" NERDTree settings
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" coc.nvim settings.
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) :<SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><cr> coc#pum#visible() ? coc#pum#confirm() : "\<cr>"
inoremap <silent><expr> <c-space> coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> K <Plug>(coc-documentation)
nnoremap <silent> <leader>ca <Plug>(coc-codeaction)
nnoremap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>qf <Plug>(coc-fix-current-issue)
nnoremap <silent> <leader>qf <Plug>(coc-fix-all-issues)

" Theme settings.
function! SwitchTheme()
  let themes = ['dracula', 'gruvbox']
  let choice = inputlist(themes, 'Select a theme: ')
  if choice > 0
    let theme = themes[choice - 1]
    if filereadable(expand('~/.vim/plugged/' . matchstr(theme, '^\w\+')))
      execute 'colorscheme' theme
      echo 'Theme switched to ' . theme
    else
      echo 'Theme ' . theme . ' not found.'
    endif
  endif
endfunction

nnoremap <leader>t :call SwitchTheme()<CR>

" tokyonight.nvim theme settings
colorscheme PaperColor " PaperColor
