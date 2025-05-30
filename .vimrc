" laststatus forces display of lightline
" Hide extraneous -- INSERT -- below lightline
set laststatus=2
set noshowmode

" speed up lightline changing word INSERT to NORMAL
set timeoutlen=50
" Set color theme

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
Plug 'frazrepo/vim-rainbow'
Plug 'plasticboy/vim-markdown'
" Plug 'junegunn/fzf.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/vim-peekaboo'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if has('nvim')
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
endif

" markdown settings
let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_math = 1

" lightline settings
let g:lightline = {'colorscheme': 'seoul256',}

" Open nerd tree by default
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" nerdtree toggle is Ctrl-n
map <C-n> :NERDTreeToggle<CR>

" show dotfiles in nerdtree
let NERDTreeShowHidden=1

" Coc explorer shortcut
" nnoremap <space>e :CocCommand explorer<CR>
" map <C-n> :CocCommand explorer<CR>

" Telescope: Find files using Telescope command-line sugar.
if has('nvim')
	nnoremap <C-f> <cmd>Telescope find_files<cr>
	nnoremap <C-j> <cmd>Telescope live_grep<cr>
	nnoremap <C-b> <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
endif


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

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
    inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    inoremap <silent><expr> <c-space> coc#refresh()

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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
 
" " Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
 
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
" === End coc config ===

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" enable rainbow brackets globally
let g:rainbow_active = 1

" terminal settings
if !has('nvim')
	set splitbelow	
	set termwinsize=10*0
endif

" set utf-8 for full emoji support
set encoding=utf-8

" open vimrc in split to see vim notes
noremap <silent> ,<space> :20sview ~/.vimrc<CR>
