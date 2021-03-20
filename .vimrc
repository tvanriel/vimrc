
let g:python3_host_prog='/usr/bin/python3'
call plug#begin('~/.vim/plugged')
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

" (Optional) Multi-entry selection UI.
Plug 'beanworks/vim-phpfmt'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'Chiel92/vim-autoformat'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tmsvg/pear-tree'
Plug 'ts-26a/vim-darkspace'
Plug 'preservim/nerdtree'
call plug#end()

set whichwrap+=<,>,[,]
set number
set nofixendofline
set expandtab
set cursorline
set path+=**
set wildmenu

" Enable the 'autoclosing' pairs.
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

set tabstop     =4
set softtabstop =4
set shiftwidth  =4

let g:AutoPairsFlyMode = 1
let g:phpfmt_standard = 'PSR2'


map <Tab><Tab> :find<Space>
map <F2> :NERDTreeToggle<Return>

" Comment line shortcuts
autocmd FileType xml,html,phtml map <buffer> <C-G> :s/^/\<\!--/ <bar> :s/$/--\>/<Esc><Esc><Down>
autocmd FileType php,sass,js,ts,go,scss map <buffer> <C-G> :s/^/\/\//<Esc><Esc><Down>
autocmd FileType py,sh map <buffer> <C-G> :s/^/#/<Esc><Esc><Down>
autocmd FileType vimrc map <buffer> <C-G> :s/^/" /<Esc><Esc><Down>
autocmd FileType vimrc map <buffer> <C-G> :s/^/" /<Esc><Esc><Down>

autocmd FileType go map <buffer> <F12> :GoDebugStart <Return>
autocmd FileType go map <buffer> <C-F12> :GoDebugBreakpoint <Return>


" Setup the colorscheme
set background=dark
set termguicolors
colorscheme darkspace


" Highlight trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" Trim the whitespace on these filetypes when the file gets saved.
autocmd BufWritePre     *.php,*.phtml,*.html,*.xml,*.css,*.sass,*.scss,*.js,*.ts,*.go,*.py,*.sh,*.vue :call TrimWhiteSpace()


let g:user_emmet_install_global = 0
autocmd FileType html,phtml,css EmmetInstall


" Autostart Nerdtree if there is no file given in the commandline args.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Write if focus is lost.
au FocusLost * silent! wa

" Format certain files when saving them, so linters won't trip over them.
au BufWrite *.php,*.html,*.go,*.sh,*.sass,*.scss,*.phtml,*.py :Autoformat
