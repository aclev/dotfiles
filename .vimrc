filetype plugin on
"
"
"install VimPlug if it doesn't exist

if empty(glob("~/.vim/autoload/plug.vim"))
        call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
endif

let g:OmniSharp_host = "http://localhost:2000""
set nocompatible

"Begin VimPlug
call plug#begin("~/.vim/plugged/")
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py'}
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-markdown'
Plug 'OmniSharp/omnisharp-vim', {'do' : 'xbuild ./server/OmniSharp.sln && ./omnisharp-roslyn/build.sh'}
Plug 'garyburd/go-explorer'
Plug 'elzr/vim-json'
Plug 'suan/vim-instant-markdown', {'do' : 'npm -g install instant-markdown-d'}
call plug#end()

"Begin YouCompleteMe settings
"========================

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

"Python Stuff
"==============
let g:syntastic_python_python_exec = '/path/to/python3'
let g:syntastic_python_checkers = ['pylint']

au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ set encoding=utf-8


"VirtualEnv Support
"=================
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
   project_base_dir = os.environ['VIRTUAL_ENV']
   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
   execfile(activate_this, dict(__file__=activate_this))
EOF

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


"Common
syntax on
:set number
:set expandtab
:set tabstop=4
:color darkblue 
set backspace=2 

"Change working directory
map <C-c><C-d> :cd %:p:h
map <C-l><C-c><C-d> :lcd %:p:h

"Format Json
map <leader>fj :%!python -m json.tool<cr>
