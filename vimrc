set nocompatible
set magic

let mapleader = ","

set t_Co=256
colorscheme railscasts

set grepprg=ack\ -H\ --nocolor\ --nogroup
set grepformat=%f:%l:%m

function! Ack(args)
  let grepprg_bak=&grepprg
  set grepprg=ack\ -H\ --nocolor\ --nogroup
  execute "silent! grep " . a:args
  botright copen
  let &grepprg=grepprg_bak
endfunction
command! -nargs=* -complete=file Ack call Ack(<q-args>)
map <leader>f :Ack<space>

" Fuzzy Finder Textmate settings
let g:fuzzy_matching_limit=200
let g:fuzzy_ceiling = 10000
let g:fuzzy_ignore = "tags;*.log;*.jpg;*.gif;*.png;.git/**/*;.svn;.svn/**/*;teamsite/**/*"

map <leader>t :FuzzyFinderTextMate<CR>
map <leader><S-t> :FuzzyFinderTag<CR>
map <leader>b :FuzzyFinderBuffer<CR>
map <leader>] :FuzzyFinderMruFile<CR>
map <leader>q :BufO<CR>
map <leader>r :Rake<CR>

" folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" set to use 'par' for formatting
set formatprg=par\ -w72qrg

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

syntax on

set wildmenu
set autoread
set nobackup
set nowritebackup
set smartindent
set gdefault
set cursorline
set nu  " Line numbers on
set nowrap  " Line wrapping off
set directory=/tmp

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" don't use folder browser when adding to project listings
let g:proj_flags='imst'
" no menu, and no toolbar:
"set guioptions-=m
set guioptions-=T

set term=xterm-256color
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

" space = pagedown, - = pageup
noremap <Space> <PageDown>
noremap - <PageUp>

" remap'd keys
"map <Tab><Tab> <C-W>w
nnoremap <F5><F5> :set invhls hls?<CR>    " use f5f5 to toggle search hilight
nnoremap <F4><F4> :set invwrap wrap?<CR>  " use f4f4 to toggle wordwrap
nnoremap <F2><F2> :vsplit<CR>
nnoremap <F3><F3> <C-W>w
map <C-t> <Esc>:%s/[ ^I]*$//<CR>:retab<CR> " remove trailing space and retab
map <silent> <C-h> ^cw                    " change first word on line

nmap <leader>s :source ~/.vimrc
nmap <leader>v :e ~/.vimrc
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <F6><F6> :TlistToggle<CR>

" backup to ~/.tmp
"set backup
"set backupdir=$HOME/.tmp
"set writebackup

" misc
"set ai
set nohls
set incsearch
set showcmd
set nowrap

let html_use_css=1

" set up pathogen to allow plugin bundling
filetype off
" following line is needed for vim-pathogen to be a submodule too
set runtimepath+=~/home/vim-pathogen
call pathogen#runtime_append_all_bundles()
" following line is for ervandew's plugins (including supertab etc)
set rtp+=~/home/ervandew-vimfiles/vim

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

" svn blame
vmap <Leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 
" svn log
vmap <Leader>l :<C-U>!svn log <C-R>=expand("%:p") <CR><CR>

" Edit routes
command! Rroutes :Redit config/routes.rb
command! RTroutes :RTedit config/routes.rb

" Edit factories
command! Rblueprints :Redit spec/blueprints.rb
command! RTblueprints :RTedit spec/blueprints.rb
