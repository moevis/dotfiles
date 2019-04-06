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

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

hi CursorLine ctermbg=235
nnoremap <leader>y "+y<cr>
nnoremap <leader>p "+p<cr>
nnoremap <leader>d "_d<cr>
nnoremap gp `[v`]
nnoremap <leader>g g`"
map mt :call MoveToNextTab()<cr>
map mT :call MoveToPrevTab()<cr>
map <leader>] :cnext<cr>
map <leader>[ :cprev<cr>
map <leader>- :ALEPrevious<cr>
map <leader>= ,ALENext<cr>
map <leader>l :set invnumber<cr>
map <leader>d :SignifyToggleHighlight<cr>
map <f5> :AsyncRun -program=make<cr>
map <f2> :LeaderfFunction!<cr>
nnoremap <c-right> :tabnext<cr>
nnoremap <c-left> :tabprevious<cr>
nmap <space><space> V
map <f10> :call <SID>ToggleQf()<cr>

vnoremap <silent> * :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>

filetype off
call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-surround'

Plug 'drmikehenry/vim-headerguard'
function! g:HeaderguardName()
  return "PROJECT_" . toupper(expand('%:gs/[^0-9a-zA-Z_]/_/g'))
endfunction

Plug 'terryma/vim-expand-region'
Plug 'liuchengxu/vim-which-key'
Plug 'sbdchd/vim-shebang'

Plug 'tpope/vim-commentary'
autocmd FileType c,cpp,json setlocal commentstring=//\ %s

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
let g:ale_lint_on_enter = 8

Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode' ],
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
" <Leader>f{char} to move to {char}
map  <Leader>t <Plug>(easymotion-bd-f)
nmap <Leader>t <Plug>(easymotion-overwin-f)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

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

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)


Plug 'junegunn/fzf.vim'
Plug 'wellle/targets.vim'
Plug 'fatih/vim-go'

Plug 'Chiel92/vim-autoformat'
let g:formatdef_clangformat = '"clang-format -style=google"'
map <leader>ff :Autoformat<cr>
let g:formatters_python = ['black']

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
let g:ycm_use_clangd = 0

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
map <leader>a= :Tab/=<cr>
map <leader>a: :Tab/:<cr>
map <leader>a, :Tab/,<cr>

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_project_root = ['.root', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_modules = []
if executable('ctags')
  let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
  let g:gutentags_modules += ['gtags_cscope']
  let g:gutentags_cache_dir = expand('~/.cache/tags')
endif

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

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
set termguicolors
highlight Normal guibg=None ctermbg=None

colorscheme gruvbox

function! VisualSelection(direction) range
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

function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    vsp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
