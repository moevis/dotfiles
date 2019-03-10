set exrc
set secure
set background=dark

set nocompatible

let g:mapleader = ','
set cmdheight=2
set ruler
set wildmenu
set nobackup
set nowb
set noswapfile
set laststatus=2
set cursorline
hi CursorLine ctermbg=235
map <leader>q :e ~/buffer<cr>
map <leader>pp :setlocal paste!<cr>
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'

Plugin 'airblade/vim-gitgutter.git'
nnoremap <silent> <leader>d :GitGutterToggle<cr>
let g:gitgutter_enabled = 1

Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'

Plugin 'scrooloose/nerdtree.git'
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>

let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeWinSize=35

Plugin 'Xuyuanp/nerdtree-git-plugin'

set completeopt-=preview
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = "left"
let NERDTreeIgnore = ['\.pyc$', '\.o$']

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

Plugin 'vim-scripts/mru.vim'
map <leader>o :BufExplorer<cr>

Plugin 'yuttie/comfortable-motion.vim'
Plugin 'jiangmiao/auto-pairs'

Plugin 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

Plugin 'Lokaltog/vim-powerline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'easymotion/vim-easymotion'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                         fzf#vim#with_preview('right', '?'),
  \                 <bang>0)

Plugin 'junegunn/fzf.vim'
Plugin 'wellle/targets.vim'

Plugin 'rhysd/vim-clang-format'
map <leader>ff :ClangFormat<cr>
let g:clang_format#code_style = 'google'

Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
nnoremap <S-f12> :vsplit<bar>YcmCompleter GoTo<CR>
nnoremap <f12> :YcmCompleter GoTo<CR>

Plugin 'SirVer/ultisnips'


Plugin 'morhetz/gruvbox'

call vundle#end()            " required
filetype plugin indent on    " required

nnoremap <f3> <C-w>-
nnoremap <f4> <C-w>+
nnoremap <f9> <C-w>>
nnoremap <f10> <C-w><

set smartindent
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set showmatch
set expandtab

colorscheme gruvbox
