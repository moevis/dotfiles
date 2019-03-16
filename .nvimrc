set exrc
set secure
set background=dark

set nocompatible

" persistant undo
set undodir=~/.vim/undodir
set undofile

let g:mapleader = ','
set cmdheight=2
set ruler
set wildmenu
set nobackup
set nowb
set noswapfile
set laststatus=2
set cursorline
set ignorecase
set smartcase

hi CursorLine ctermbg=235
map <leader>q :e ~/buffer<cr>
map <leader>pp :setlocal paste!<cr>
map <leader>] :cnext<cr>
map <leader>[ :cprev<cr>
map <leader>- :ALEPrevious<cr>
map <leader>= :ALENext<cr>
map <f5> :AsyncRun -program=make<cr>
map <f2> :LeaderfFunction!<cr>
nnoremap <c-right> :tabnext<cr>
nnoremap <c-left> :tabprevious<cr><paste>

vnoremap <silent> * :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>

filetype off
call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'
nnoremap <silent> <leader>d :GitGutterToggle<cr>
let g:gitgutter_enabled = 1

Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'

Plug 'scrooloose/nerdtree'
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeWinSize=35

Plug 'Xuyuanp/nerdtree-git-plugin'

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

Plug 'vim-scripts/mru.vim'
map <leader>o :BufExplorer<cr>

Plug 'yuttie/comfortable-motion.vim'
Plug 'jiangmiao/auto-pairs'

Plug 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'charvaluehex': '0x%B'
      \ },
      \ }
Plug 'bronson/vim-trailing-whitespace'
Plug 'easymotion/vim-easymotion'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                         fzf#vim#with_preview('right', '?'),
  \                 <bang>0)
nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

Plug 'junegunn/fzf.vim'
Plug 'wellle/targets.vim'

Plug 'rhysd/vim-clang-format'
map <leader>ff :ClangFormat<cr>
let g:clang_format#code_style = 'google'

Plug 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
nnoremap <S-f12> :vsplit<bar>YcmCompleter GoTo<CR>
nnoremap <f12> :YcmCompleter GoTo<CR>

Plug 'SirVer/ultisnips'
let g:SuperTabDefaultCompletionType = '<C-n>'

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

Plug 'junegunn/vim-peekaboo'
let g:peekaboo_window='vert bo 50new'
let g:peekaboo_prefix='<leader>'

Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 8

Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup = 1

Plug 'morhetz/gruvbox'

call plug#end()
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

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
