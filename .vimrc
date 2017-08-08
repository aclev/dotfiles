filetype plugin on
set nocompatible
syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2 
set t_Co=256
set background=light


"Begin VimPlug
call plug#begin("$HOME/.vim/plugged/")
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py'}
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
Plug 'venantius/vim-eastwood'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'garyburd/go-explorer'
Plug 'elzr/vim-json'
Plug 'suan/vim-instant-markdown', {'do' : 'npm -g install instant-markdown-d'}
call plug#end()

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
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:syntastic_clojure_checkers = ['eastwood']


"Begin vim-markdow
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'go', 'objc']

"Change vim windows
nmap <silent> <A-j> :wincmd j<CR> 
nmap <silent> <A-l> :wincmd k<CR> 
nmap <silent> <A-h> :wincmd h<CR> 
nmap <silent> <A-l> :wincmd l<CR> 


"Change working directory
map <C-c><C-d> :cd %:p:h
map <C-l><C-c><C-d> :lcd %:p:h

"Format Json
map <leader>fj :%!python -m json.tool<cr>
