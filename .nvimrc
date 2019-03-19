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
map <f10> :call <SID>ToggleQf()<cr>

vnoremap <silent> * :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>

filetype off
call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-surround'

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
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \ },
      \ 'component': {
      \    'charvaluehex': '0x%B'
      \ }
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
Plug 'fatih/vim-go'

Plug 'Chiel92/vim-autoformat'
let g:formatdef_clangformat = '"clang-format -style=google"'
map <leader>ff :Autoformat<cr>

Plug 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
nnoremap <S-f12> :vsplit<bar>YcmCompleter GoTo<CR>
nnoremap <f12> :YcmCompleter GoTo<CR>
nnoremap <f11> :YcmCompleter FixIt<CR>

Plug 'SirVer/ultisnips'
let g:SuperTabDefaultCompletionType = '<C-n>'

Plug 'junegunn/vim-peekaboo'
let g:peekaboo_window='vert bo 50new'
let g:peekaboo_prefix='<leader>'

Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 8

Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup = 1

Plug 'mhinz/vim-signify'

Plug 'godlygeek/tabular'
map <leader>a= :Tabularize /=<cr>
map <leader>a: :Tabularize /:<cr>
map <leader>a, :Tabularize /,<cr>

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_project_root = ['.root', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
  let g:gutentags_modules += ['gtags_cscope']
  let g:gutentags_cache_dir = expand('~/.cache/tags')
endif

set csprg='gtags-cscope'
set cscopeprg='gtags-cscope'
let g:gutentags_auto_add_gtags_cscope = 0
noremap <silent> <leader>sI :GscopeFind i <C-R>=expand("%:t")<cr><cr>

Plug 'skywind3000/gutentags_plus'
let g:gutentags_plus_switch = 1

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
map <f4> :LeaderfBufferAll<cr>
map <f3> :Leaderf mru --regexMode<cr>
map <f2> :LeaderfFunction!<cr>
map <f1> :LeaderfTag<cr>

Plug 'christoomey/vim-tmux-navigator'
Plug 'morhetz/gruvbox'
call plug#end()
filetype plugin indent on    " required

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

function! s:ToggleQf()
  for buffer in tabpagebuflist()
    if bufname(buffer) == ''
      " then it should be the quickfix window
      cclose
      return
    endif
  endfor

  copen
endfunction
