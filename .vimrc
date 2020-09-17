" === VIM NOTES ===
" /search
" Ctrl-V: Visual block mode (multi line)
" I: (in block mode) insert BEFORE selected block, this is how we add comment
" :tabn next tab
" :tabp prev tab
" \"ay (note: ignore escape) yank to register a
" \"+y or "*y access clipboard. +=ctrl-c, *=X11 clipboard

" === vimrc BEGINS === 
" laststatus forces display of lightline
" Hide extraneous -- INSERT -- below lightline
set laststatus=2
set noshowmode

" speed up lightline changing word INSERT to NORMAL
set timeoutlen=50
" Set color theme

" color theme
colorscheme ron

" show line numbers
set number
set relativenumber

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'frazrepo/vim-rainbow'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" markdown settings
let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_math = 1

" lightline settings
let g:lightline = {'colorscheme': 'seoul256',}

" Open nerd tree by default
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" nerdtree toggle is Ctrl-n
map <C-n> :NERDTreeToggle<CR>

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" set tabwidth to 4
set tabstop=4
set shiftwidth=4

" map Esc to jk and kj
imap jk <Esc>
imap kj <Esc>

" === coc.nvim default settings ===
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
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
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" enable rainbow brackets globally
let g:rainbow_active = 1

" terminal settings
set splitbelow
set termwinsize=10x0

" set utf-8 for full emoji support
set encoding=utf-8
