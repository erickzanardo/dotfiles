set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Vundle.vim'
Plugin 'quabug/vim-gdscript'
Bundle 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-ruby/vim-ruby'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'jparise/vim-graphql'
Plugin 'pangloss/vim-javascript'
Plugin 'ap/vim-css-color'
Plugin 'mxw/vim-jsx'
Plugin 'flowtype/vim-flow'
Plugin 'w0rp/ale'
Bundle 'moll/vim-node'
Bundle 'posva/vim-vue'
Bundle 'dart-lang/dart-vim-plugin'
Plugin 'Shougo/deoplete.nvim'
Plugin 'ervandew/supertab'
Plugin 'natebosch/vim-lsc'
Plugin 'keith/swift.vim'
Plugin 'kamykn/skyhawk'

call vundle#end()            " required
filetype plugin indent on    " required

" Search highlight and searching as you type
set hlsearch
set incsearch

" JSX enabled for js files
let g:jsx_ext_required = 0

" Theme
syntax enable
set t_Co=256
colorscheme skyhawk
set background=dark

set encoding=utf8

set expandtab
set tabstop=2
set ruler
set nu
set statusline+=%F
set laststatus=2
set autoread
set mouse=a
set autoindent
set cursorline
set pastetoggle=<F2>
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

let g:lightline = { 'colorscheme': 'wombat' }

filetype plugin indent on


autocmd FileType gdscript setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType make setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType sh setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType html setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType ejs setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType erb setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType typescript setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType java setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType css setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType scss setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType json setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType coffee setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType lua setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType graphql setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType dart setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType swift setlocal expandtab tabstop=4 shiftwidth=4

" gradle as groovy
au BufNewFile,BufRead *.gradle setf groovy

" Window moving
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Resize control
nmap <left> :vertical resize -5<CR>
nmap <up> :resize -5<CR>
nmap <down> :resize +5<CR>
nmap <right> :vertical resize +5<CR>

" Copy/Paste
vmap <C-c> "+y
nmap <C-b> "+p

" NERDTree
" Autoopen
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open shortcut
map <C-n> :NERDTreeToggle<CR>

" erb files bugs
au BufNewFile,BufRead *.html.erb set filetype=html
au BufNewFile,BufRead *.js.erb set filetype=javascript

" lua views files
au BufNewFile,BufRead *.etlua set filetype=html

" Reset the listchars
set listchars=""
" a tab should display as " ", trailing whitespace as "."
set listchars=tab:\ \
" show trailing spaces as dots
set listchars+=trail:.
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<

" ctrlp ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|class|war)$'
  \ }
" Follow symbolic links
let g:ctrlp_follow_symlinks = 1

" So react auto reload works ¯\_(ツ)_/¯
:set backupcopy=yes

" only enable flow if .flowconfig exists
if filereadable(".flowconfig")
  let g:flow#enable = 1
else
  let g:flow#enable = 0
endif

" ctrlp ignore
set wildignore+=node_modules

" Trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Vertical and Horizontal
command Horizontal windo wincmd K
command Vertical windo wincmd H

" ALE config
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

" Vue vim disabling pre processors as it really slows down vim
let g:vue_disable_pre_processors=1

" Indent
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" Deoplete
let g:deoplete#enable_at_startup = 1

" Using relative path for paths autocomplete
let g:deoplete#file#enable_buffer_path = 1

" Adjusting Deoplete tab order
let g:SuperTabDefaultCompletionType = "<c-n>"

" lsc
let g:lsc_server_commands = {'dart': 'dart_language_server'}
let g:lsc_auto_map = v:true

" map gf to open on a slit
nnoremap fg <C-W>f

" Terminal
tnoremap <Esc> <C-\><C-n>
command Term below new term://bash
command VTerm vsplit term://bash
