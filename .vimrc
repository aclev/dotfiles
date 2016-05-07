filetype plugin on

set nocompatible
syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set noexpandtab!
set backspace=2 
set t_Co=256
set background=light

"
"
"install VimPlug if it doesn't exist

let vimPlugDir = ""
let vimPlugInstall = ""
if has('win32')
    let vimPlugDir = "$HOME/vimfiles/autoload/"
    let vimPlugInstall = "powershell mkdir " . vimPlugDir . "; curl -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile $HOME/vimfiles/autoload/plug.vim"
else 
    let vimPlugDir = "$HOME/.vim/autoload"
    let vimPlugInstall = "curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif
if empty(glob(vimPlugDir . "/plug.vim"))
    call system(vimPlugInstall)
endif

let g:OmniSharp_host = "http://localhost:4111""

"Begin VimPlug
call plug#begin("$HOME/.vim/plugged/")
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py'}
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-markdown'
Plug 'OmniSharp/omnisharp-vim', {'do' : 'xbuild ./server/OmniSharp.sln && ./omnisharp-roslyn/build.sh'}
Plug 'garyburd/go-explorer'
Plug 'elzr/vim-json'
Plug 'suan/vim-instant-markdown', {'do' : 'npm -g install instant-markdown-d'}
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
call plug#end()

"Begin YouCompleteMe settings
"========================
"

let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g   :YcmCompleter GoToDefinitionElseDeclaration<CR>
"End YouCompleteMe settings
"========================

let pyhton_highlight_all=1

"enable folding
set foldmethod=indent
set foldlevel=99
set shell=bash
"some bell thing for MavVim, not sure what is does
set vb

"GoLang Stuff
"===========
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands

    autocmd!
    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END



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
