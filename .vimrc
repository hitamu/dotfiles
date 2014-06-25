"" Layouts
" Favorite colorscheme
if(has('gui_running'))
    colorscheme solarized
    ""set guifont=inconsolata\ 11
    ""set guifont=terminus\ 11
    set guifont=Inconsolata\ for\ Powerline\ 11
    set background=dark
else 
    colorscheme dante
endif

" Gvim config to see more text
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=l  "remove left-hand scroll bar
:set guioptions-=m  "remove menu bar
:set guioptions-=L  "remove left-hand scroll bar when split 

" Basics setting
set laststatus=2 
set tags=/home/hitamu/workspace/php.tags
set path=/home/hitamu/workspace
set nocompatible
set showcmd
set foldmethod=manual
set autoindent
set nobackup
set noswapfile
set lbr
set tw=500
set wildignore=*.o,*~,*.class
set expandtab
set smarttab
set wildmenu
set wildmode=list:longest,full
set mouse=a
set autochdir
set number
set ignorecase
set smartcase
set shiftwidth=4
set softtabstop=4
set hlsearch
set incsearch
set scrolloff=25
set sidescrolloff=5
set sidescroll=1
set ruler
""set colorcolumn=120
set showmode
set lazyredraw
set gdefault
set title
set encoding=utf-8

" Setting airline
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

" vim-powerline symbols
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

filetype on
filetype plugin on
syntax enable

" Mappings

let mapleader = ","

" Tabs
nnoremap <silent> <C-Tab> :tabnext<CR>
nnoremap <silent> <C-S-Tab> :tabprevious<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-q> :tabclose<CR>

nnoremap <silent> <leader>ev :e $MYVIMRC<CR>

nnoremap <C-a> <home>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h :split<CR>

nnoremap <leader>< <C-w><
nnoremap <leader>> <C-w>>
nnoremap <leader>+ <C-w>+
nnoremap <leader>- <C-w>-

nnoremap <leader>z za

nnoremap J 5<C-e>
nnoremap K 5<C-y>
nnoremap H ['
nnoremap L ]'

" Copy & paste to the clipboard
vnoremap <C-c> "+y
nnoremap <C-v> "+p

" DmenuVimSearch
nnoremap <c-f> :call DmenuOpen("e")<cr>

" Automatical cd to current directory
noremap gc :lcd %:h<Cr>

inoremap {<CR> {}<Left><CR><CR><Up><Tab>

inoremap jj <Esc>
inoremap ,, <End>,
inoremap ;; <End>;

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Configure fuzzyfinder
map <leader>f :FufFile <C-r>=fnamemodify(getcwd(), ':p')<CR><CR>
map <leader>d :FufDir<CR>

" Configure NERDTree
map <leader>t :NERDTree<CR>
map <leader>T :NERDTreeClose<CR>

" Configure MRU 
map <leader>r :MRU<CR>

" Restart
map <leader>R :Restart<CR>

" Quit without save
map <leader>q :q<cr>

" Save
map <leader>w :w<cr>

autocmd BufEnter * lcd %:p:h 
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Pathogen and Powerline 
""call pathogen#infect()
""let g:Powerline_symbols = 'fancy'

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif 

" Set off the other paren
highlight MatchParen ctermbg=4

" Java compelte
"":setlocal omnifunc=javacomplete#Complete 

" Strip the newline from the end of a string 
function! Chomp(str)
    return substitute(a:str, '\n$', '', '')
endfunction
" Find a file and pass it to cmd
function! DmenuOpen(cmd)
    let fname = Chomp(system("find /home/hitamu/ | dmenu -i -l 20 -p " . a:cmd))
    if empty(fname)
        return
    endif
    execute a:cmd . " " . fname
endfunction

function! SetExecutableBit()
  let fname = expand("%:p")
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  silent !chmod a+x %
  checktime
  execute "au! FileChangedShell " . fname
endfunction
command! Xbit call SetExecutableBit()
