filetype plugin on
set nocompatible
syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
"set background=dark

"Begin VimPlug
call plug#begin("$HOME/.vim/plugged/")
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --gocode-completer'}
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'vim-scripts/paredit.vim'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-dispatch'
Plug 'garyburd/go-explorer'
Plug 'elzr/vim-json'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'altercation/vim-colors-solarized'
Plug 'kien/rainbow_parentheses.vim'
call plug#end()

:imap jk <Esc>
:vmap jk <Esc>

let mapleader=","

set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

autocmd VimEnter *       RainbowParenthesesToggle
autocmd Syntax   clojure RainbowParenthesesLoadRound
autocmd Syntax   clojure RainbowParenthesesLoadSquare
autocmd Syntax   clojure RainbowParenthesesLoadBraces

"Cljfmt settings
let g:clj_fmt_autosave = 0



" Custom syntax highlighting for trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

nnoremap <Leader>wn :match ExtraWhitespace /^\s* \s*\<Bar>\s\+$/<CR>
nnoremap <Leader>wf :match<CR>

" Fireplace fires FireplaceEvalPost and FireplaceEvalPre
" Even though it does it as silent because vim-eastwood redirects the output
" comes in though the eastwood calls (No matching autocommand)...
" So, just make them do nothing...

augroup fireplace
    autocmd!
    "autocmd User FireplacePreConnect <Nop>
    "autocmd User FireplaceEvalPost <Nop>
augroup END


"Paraedit settings
let g:paredit_leader = ','
let g:paredit_electric_return=0
map <leader>tp :call PareditToggle()<CR>

"Begin YouCompleteMe settings
"========================
"

let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g   :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_semantic_triggers = {'clojure' : ['/', '(', "."]}
"End YouCompleteMe settings
"========================

"enable folding
set foldmethod=indent
set foldlevel=99
set shell=bash
"some bell thing for MavVim, not sure what is does
set vb

"GoLang Stuff
"===========
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Get Code Issues and syntax errors
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'clojure'] }
let g:syntastic_clojure_checkers = ['eastwood']

nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-l> :wincmd k<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>


" Markdown settings
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'go', 'objc']
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'

"Change vim windows
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-l> :wincmd k<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

"Paste mode toggling
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"Change working directory
map <C-c><C-d> :cd %:p:h
map <C-l><C-c><C-d> :lcd %:p:h

"Format Json
map <leader>fj :%!python -m json.tool<cr>
