" ===DEFAULTS===
runtime! debian.vim

if has("syntax")
"  syntax on
endif

"Dark editing area => light syntax highlight
set background=dark

" Open to the same line each time
au BufWinLeave * mkview
" au BufWinEnter * silent loadview

filetype plugin indent on

set showcmd		" Show (partial) command in status line.
set noshowmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" USER
syntax on
set noerrorbells
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set nosmartindent
set wrap
set smartcase
set noswapfile
set nobackup
set incsearch
set number relativenumber
set nu rnu

" Custom undo directory
set nobackup
set undodir=~/.vim/undodir
set undofile

call plug#begin('~/.vim/plugged')

Plug 'sonph/onehalf'
Plug 'preservim/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch':'release'}", {'do': { -> coc#util#install()}}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

colorscheme onedark
let g:airline_theme='onedark'

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" if exists('+termguicolors')
" endif

"set colorcolumn=100
"highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight CursorLineNr guifg=yellow

let mapleader = " "

"===NERD TREE
"Auto start nerdtree
autocmd vimenter * NERDTree | wincmd l

"Map ctr-n to nerd tree
map <C-n> :NERDTreeToggle<CR>

" Remover nerd tree help
let g:netrw_banner = 0

"close if nerd tree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:netrw_browse_split=2
let g:netrw_winsize = 25

"===CPP
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

"===REMAPS
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>t gt
nnoremap <leader>T gT

nnoremap <leader>u :UndotreeShow<CR>

nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <leader>\ @<CR>

" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>

autocmd FileType cpp inoremap {<CR>  <CR>{<CR>}<ESC>O
autocmd FileType cpp inoremap {;<CR> <CR>{<CR>};<ESC>O
autocmd FileType cpp set foldmethod=syntax

" COC
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
   \ pumvisible() ? "\<C-n>" :
   \ <SID>check_back_space() ? "\<TAB>" :
   \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>] <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
 execute 'h '.expand('<cword>')
else
 call CocAction('doHover')
endif
endfunction
 
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup ENDu

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Using CocList Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
