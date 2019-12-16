filetype plugin on
set nocompatible
syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2

"Begin VimPlug
call plug#begin("$HOME/.vim/plugged/")
"Plug 'clojure-vim/async-clj-omni'

"Plug 'ncm2/ncm2'
"    Plug 'roxma/nvim-yarp'
"
"    "" enable ncm2 for all buffers
"    autocmd bufenter * call ncm2#enable_for_buffer()
"
"    "" important: :help ncm2popupopen for more information
"    set completeopt=noinsert,menuone,noselect
"    set shortmess+=c
"    Plug 'ncm2/ncm2-bufword'
"    Plug 'ncm2/ncm2-path'
"    let g:ncm2#complete_delay=300
"    let g:ncm2#popup_delay=300
"    let g:ncm2#popup_limit=8
"    let g:ncm2#total_popup_limit=15
Plug 'ervandew/supertab'

Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'vim-syntastic/syntastic'
Plug 'venantius/vim-cljfmt'
Plug 'venantius/vim-eastwood'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'vim-scripts/paredit.vim'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'garyburd/go-explorer'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'elzr/vim-json'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'iamcco/markdown-preview.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()


:set statusline=%f\ %Y\ Col:\ %c\ File-Len:\ %L

:imap jk <Esc>
:vmap jk <Esc>

let mapleader=","

set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

"Cljfmt settings
let g:clj_fmt_autosave = 0

"Rainbow Parens
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
call g:rainbow_parentheses#activate()

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

"augroup fireplace
    "autocmd!
    "autocmd User FireplacePreConnect <Nop>
    "autocmd User FireplaceEvalPost <Nop>
"augroup END


"Paraedit settings
let g:paredit_leader = ','
let g:paredit_electric_return=0
map <leader>tp :call PareditToggle()<CR>

"Begin YouCompleteMe settings
"========================
"

let g:ycm_server_use_vim_stdout = 0
"let g:ycm_server_keep_logfiles = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g   :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_semantic_triggers = {'clojure' : ['/', '(', "."]}

"End YouCompleteMe settings
"========================

"enable folding
set foldmethod=indent
set foldlevel=99
set shell=fish
set hidden
"some bell thing for MavVim, not sure what is does
set vb

"Rust stuff
"==========
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

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
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'clojure']}
let g:syntastic_clojure_checkers = ['eastwood']

nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-l> :wincmd k<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>


" Markdown settings
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'go', 'objc', 'clojure']
let vim_markdown_preview_browser='FireFox'

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

"Cljfmt
map <leader>fc :%!cljfmt fix<cr>

"nvim-clj stuff
let g:clj_nvim_plugin_tcp_chan = 0
let g:nvim_tcp_plugin_channel = 0

function! ReloadFile()
  " save the current cursor position
  let position = getpos(".")
  " delete all lines
  %d
  " read the file back into the buffer
  r
  " remove the superfluous line
  1d
  " restore the cursor position if a:is_force_pos
  call setpos(".", position)
endfunc

function! MyCljfmt()
    let result = system("cljfmt fix" + expand('%:p'))
    call ReloadFile()
endfunc

command! Cf call MyCljfmt()


function! SendMessageV2(msg)
    call rpcnotify(g:nvim_tcp_plugin_channel, a:msg)
endfunction

function! SendMessage(chan, msg)
    let res = rpcnotify(a:chan, a:msg)
    return res
endfunction

function! CljHello()
    echo g:clj_nvim_plugin_tcp_chan
    call SendMessage(g:clj_nvim_plugin_tcp_chan, 'CljHello')
endfunction

function! StartServer()
    let g:clj_nvim_plugin_tcp_chan = jobstart(['java', '-jar', '/Users/ace/code/aclev/vim-clj/target/vim-clj-0.1.0-SNAPSHOT-standalone.jar'], {'rpc': v:true})
    echo g:clj_nvim_plugin_tcp_chan
endfunction

function! StopServer()
    call SendMessage(g:clj_nvim_plugin_tcp_chan, 'CLjStop')
endfunction


" auto-complete
let g:SuperTabDefaultCompletionType="context"
au FileType clojure let b:SuperTabCompletionContexts =
  \ ['ClojureContext'] + g:SuperTabCompletionContexts
function! ClojureContext()
  let curline = getline('.')
  let cnum = col('.')
  let synname = synIDattr(synID(line('.'), cnum - 1, 1), 'name')
  if curline =~ '(\S\+\%' . cnum . 'c' && synname !~ '\(String\|Comment\)'
    return "\<c-x>\<c-o>"
  endif
endfunction
