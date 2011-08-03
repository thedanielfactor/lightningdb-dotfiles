set nocompatible
set magic
syntax on

let mapleader = ","

set nohls
set incsearch
set showcmd

set hidden
set wildmenu
set autoread
set nobackup
set nowritebackup
set smartindent
set gdefault
set cursorline
set nu     " Line numbers on
set nowrap " Line wrapping off
set directory=/tmp

" need both of these for vim to startup with whitespace and line-endings
" switched off
set list
:set list!

" set to use 'par' for formatting
set formatprg=par\ -w72qrg

" Command-T settings
let g:CommandTMaxHeight = 15
set wildignore+=vendor/rails/**,teamsite/**

" Visual
set showmatch " Show matching brackets.
set mat=5     " Bracket blinking.
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" no toolbar, no menu
set guioptions-=T
set guioptions-=m

" os x backspace fix
set backspace=indent,eol,start
"set t_kb
fixdel

" tabs -> spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" turn mouse on
set mouse=a

" %% expands to the current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

" #########################
" BINDINGS
" #########################
nnoremap <leader><leader> <c-^>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

map <leader>q :BufO<CR>

map <leader>f :Ack<space>
" A function to search for word under cursor
function! SearchWord()
   normal "zyiw
   exe ':Ack '.@z
endfunction
map <leader>F :call SearchWord()<CR>

" space = pagedown, - = pageup
noremap <Space> <PageDown>
noremap - <PageUp>

nnoremap <F2><F2> :vsplit<CR>
nnoremap <F4><F4> :set invwrap wrap?<CR>  " use f4f4 to toggle wordwrap
nnoremap <F5><F5> :set invhls hls?<CR>    " use f5f5 to toggle search hilight
" Yankring Show
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

map <C-t> <Esc>:%s/[ ^I]*$//<CR>:retab<CR> " remove trailing space and retab

nmap <leader>s :source ~/.vimrc<CR>
nmap <leader>v :e ~/.vimrc<CR>

nnoremap <leader>d :NERDTreeToggle<CR>

nmap <S-H> :BufSurfBack<CR>
nmap <S-L> :BufSurfForward<CR>

" CTags
map <Leader>rt :!ctags --extra=+f --exclude=teamsite --exclude=public -R *<CR><CR>

" Flush Command T (rescans directories)
map <Leader>tf :CommandTFlush<CR>
map <Leader>t :CommandT<CR>

" Toggle off whitespace highlighting
map <Leader>w :set list!<CR>

" #########################
" END BINDINGS
" #########################

" #### From DestroyAllSoftware screencast on file navigation in vim
set winwidth=84 " always have enough width to view file
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
"set winheight=5
"set winminheight=5
"set winheight=999
" ####

let html_use_css=1

filetype off " set up pathogen to allow plugin bundling
set runtimepath+=~/home/vim-pathogen " for vim-pathogen to be a submodule too
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

let g:snippets_dir='~/home/vim/bundle/snipmate-snippets,~/home/vim/ldb-snippets'

" vimwiki options
let g:vimwiki_list = [{ 'path': '~/vimwiki/', 'ext': '.txt' }]

command! Rroutes :Redit config/routes.rb
command! Rblueprints :Redit spec/blueprints.rb

if exists(":Tabularize")
  nmap <Leader>a\= :Tabularize /=<CR>
  vmap <Leader>a\= :Tabularize /=<CR>
  nmap <Leader>a\: :Tabularize /:\zs<CR>
  vmap <Leader>a\: :Tabularize /:\zs<CR>
  nmap <Leader>a\| :Tabularize /\|<CR>
  vmap <Leader>a\| :Tabularize /\|<CR>
endif

" #### From DestroyAllSoftware screencast on file navigation in vim
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!bundle exec spec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:ldb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:ldb_test_file")
        return
    end
    call RunTests(t:ldb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>r :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>R :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

set t_Co=256
colorscheme solarized
set background=light

