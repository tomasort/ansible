syntax on               " enable syntax highlighting
set cursorline          " highlight the current line
" set background=dark   " darker color scheme
set ruler             " show line number in bar
set nobackup            " don't create pointless backup files; Use VCS instead
set autoread            " watch for file changes
set number              " show line numbers
set nu rnu              " show relative line numbers
set showcmd             " show selection metadata
set showmode            " show INSERT, VISUAL, etc. mode
set showmatch           " show matching brackets
set autoindent smartindent  " auto/smart indent
set smarttab            " better backspace and tab functionality
set scrolloff=8         " show at least 8 lines above/below
set mouse=a
set ruler
set laststatus=2
set ignorecase
set smartcase
set undofile

" Redraw screen and remove search highlighting
nnoremap <C-L> :nohl<CR><C-L>

filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins
" colorscheme cobalt      " requires cobalt.vim to be in ~/.vim/colors

" column-width visual indication
" let &colorcolumn=join(range(81,999),",")
" highlight ColorColumn ctermbg=235 guibg=#001D2F

" tabs and indenting
set autoindent          " auto indenting
set smartindent         " smart indenting
set expandtab           " spaces instead of tabs
set tabstop=4           " 2 spaces for tabs
set shiftwidth=4        " 2 spaces for indentation

" bells
set noerrorbells        " turn off audio bell
set visualbell          " but leave on a visual bell

" search
set hlsearch            " highlighted search results
set showmatch           " show matching bracket

" other
set guioptions=aAace    " don't show scrollbar in MacVim
" call pathogen#infect()  " use pathogen

" clipboard
set clipboard=unnamed   " allow yy, etc. to interact with OS X clipboard

" shortcuts
map <F2> :NERDTreeToggle<CR>

" remapped keys
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

nnoremap <leader>x :!chmod +x %<CR>
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>
" PLUGINS
" -----------------------------------
call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
" ------------------------------------
             
" Fix the paste problem ( DELETE if using nvim)

if exists("g:loaded_bracketed_paste")
  finish
endif
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te = "\e[?2004l" . &t_te

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
            
     
     
     
    
     
     
     
     
    
     
     
