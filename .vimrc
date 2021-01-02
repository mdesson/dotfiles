" === VIM NOTES ===
" /search
" <Ctrl-g> Next occurence of pattern
" <Ctrl-t> Previous occurence of pattern
" Ctrl-V: Visual block mode (multi line)
" I: (in block mode) insert BEFORE selected block, this is how we add comment
" :tabn next tab
" :tabp prev tab
" \"ay (note: ignore escape) yank to register a
" \"+y or "*y access clipboard. +=ctrl-c, *=X11 clipboard

" === Efficient Changes ===
" da" [d]elete [a]round double quotes
" di] [d]elete [i]nside square brackets
" ci{ [c]hange [i]nside curly braces
" dap [d]elete [a]round [p]aragraph
" vaw [v]isually select [a]round [w]ord

" === Quick Replacements ===
" dtc [d]elete [t]o next `c`
" cf, [c]change [f]orward to the `,`
" ya' [y]ank [a]round `'`

" === Change Until Pattern ===
" d/foo<Enter> 		Delete up until `foo` is found
" c/bar<Enter> 		Change everything up to `bar`
" y/pattern<Enter> 	Yank everything until `pattern`

" === Resize Splits ===
" <Ctrl-w> - Decrease height of split by one line
" <Ctrl-w> + Increase height of split by one line
" <Ctrl-w> > Decrease width of split by one line
" <Ctrl-w> < Decrease width of split by one line
" <Ctrl-w> = Make all splits equal size
" 5 <Ctrl-w> > Make left split 5 columns wider
" <Ctrl-w> J Switch orientation of splits

" === Editing Visual Selections ===
" o Move cursor to [o]pposite side of selection

" === Find and Replace Across Files ===
" 1) Populate args list with list of files
" :args path/to/file/glob/*.js
" 2) Perform substitution across files
" :argdo %s/pattern/replacement/g
" 3) Save files
" :argdo update
" === Terminal ===
" <Ctrl-w> N scroll through terminal
" i stop scrolling

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
Plug 'junegunn/vim-peekaboo'

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

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

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

" Formatting selected code.
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
set splitbelow
set termwinsize=15*0

" set utf-8 for full emoji support
set encoding=utf-8

" open vimrc in split to see vim notes
noremap <silent> ,<space> :20sview ~/.vimrc<CR>
