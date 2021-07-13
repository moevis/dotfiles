set exrc

set secure
set hidden
let g:tmux_navigator_disable_when_zoomed = 1

set nocompatible

if filereadable(expand("~/.local/share/nvim/site/autoload/plug.vim")) == 0
  echoerr "Plug manager not installed, downloading from http://data.moevis.cc/plug.vim"
  call system("mkdir -p ~/.local/share/nvim/site/autoload/ && wget http://data.moevis.cc/plug.vim -O ~/.local/share/nvim/site/autoload/plug.vim")
  so ~/.local/share/nvim/site/autoload/plug.vim
endif

" backup
set backup
set backupdir=~/.vim/backup
if filereadable(expand("~/.vim/backup")) == 0
  call system("mkdir -p ~/.vim/backup")
endif
set writebackup
set backupcopy=yes
au BufWritePre * let &bex = '@' . strftime("%F")

" undo
set undodir=~/.vim/undodir
set undofile

set autoread
set splitright
let g:mapleader = ','
set cmdheight=2
set wildoptions=pum
set pumblend=20
set wildmenu
" set nobackup
set nowb
set noswapfile
set nu
set laststatus=2
set cursorline
set ignorecase
set smartcase

if &wildoptions == "pum"
  cnoremap <expr> <up>   pumvisible() ? "<C-p>" : "\<up>"
  cnoremap <expr> <down> pumvisible() ? "<C-n>" : "\<down>"
  cnoremap <expr> <left> pumvisible() ? "<up>" : "<left>"
  cnoremap <expr> <right> pumvisible() ? "<C-e>" : "<right>"
endif

let g:DirDiffExcludes = "node_modules,.*,CMakeFiles,build,__pycache__,*.log"
autocmd FileType json syntax match Comment +\/\/.\+$+
tnoremap <esc> <c-\><c-n><cr>
map <leader>cc :checktime<cr>

hi CursorLine ctermbg=248
vnoremap <leader>y "+y<cr>
map <leader>p "+p<cr>
vnoremap <leader>x "_d<cr>
nnoremap gp `[v`]
nnoremap <leader>g g`"
map mt :call MoveToNextTab()<cr>
map mT :call MoveToPrevTab()<cr>
map [q :cprev<cr>
map ]q :cnext<cr>
map <leader>l :set invnumber<cr>
map <leader>d :SignifyToggleHighlight<cr>
map <f5> :AsyncRun -program=make<cr>
map <f6> :GoTest<cr>
nnoremap <c-right> :tabnext<cr>
nnoremap <c-left> :tabprevious<cr>
map <f10> :call <SID>ToggleQf()<cr>

vnoremap <silent> * :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>

filetype off
call plug#begin()
Plug 'roxma/vim-encode'
Plug 'tpope/vim-surround'
Plug 'drmikehenry/vim-headerguard'
Plug 'sbdchd/vim-shebang'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'will133/vim-dirdiff'
Plug 'godlygeek/tabular'

Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'

Plug 'tpope/vim-commentary'
autocmd FileType c,cpp,json setlocal commentstring=//\ %s

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

let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinPos = "left"
let NERDTreeIgnore = ['\.pyc$', '\.o$']

let g:NERDTreeGitStatusIndicatorMapCustom = {
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
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'relativepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'gitbranch#name',
      \ },
      \ 'component': {
      \ }
      \ }
Plug 'bronson/vim-trailing-whitespace'

Plug 'easymotion/vim-easymotion'
map  <space> <Plug>(easymotion-sn)
omap <space> <Plug>(easymotion-tn)

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 fzf#vim#with_preview('right', '?'),
      \                 <bang>0)
nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
cmap W w
nmap <Leader>gg :Files<CR>

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

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'wellle/targets.vim'
Plug 'liuchengxu/vim-clap'

Plug 'voldikss/vim-floaterm'
map <f2> :FloatermToggle<cr>

Plug 'fatih/vim-go'
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_complete_unimported = 1
let g:go_auto_type_info = 1

Plug 'Chiel92/vim-autoformat'
let g:formatdef_clangformat = '"clang-format -style=google"'
map <leader>ff :Autoformat<cr>
let g:formatters_python = ['black']
let g:formatters_html = ['tidy']
let g:formatdef_yamlfmt = '"yamlfmt"'
let g:formatters_yaml = ['yamlfmt']

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile' }
map <backspace> :nohl<cr>

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[d` and `]d` for navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current
" paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <f1> :CocList diagnostics<cr>
nmap <f9> :CocListResume<cr>
nmap <f11>  <Plug>(coc-fix-current)"

" need to install coc-prettier to run :Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use K for show documentation in preview window
nnoremap <silent> <leader>r :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

Plug 'honza/vim-snippets'

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
let g:gruvbox_transparent_bg=1
highlight Normal guibg=none
highlight NonText guibg=none

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
    exe "tabnew"
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
    vsp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! s:get_visual_selection()
  try
    let a_save = @a
    normal! gv"ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

augroup secure_modeline_conflict_workaround
  autocmd!
  autocmd FileType help setlocal nomodeline
augroup END

map <f1> <nop>

" Move visual block
vnoremap <c-up> :m '>+1<CR>gv=gv
vnoremap <c-down> :m '<-2<CR>gv=gv

" go substitute because the default map for sleeping is silly
nnoremap <leader>s :%s//g<Left><Left>
nnoremap <leader>ss :%s//<Left>

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

map <f3> :%s/"\zs.*\ze"/\=substitute(submatch(0), '\\\@<!"', '\\"', 'g')<cr>
map <f8> :GoDecls<cr>

let g:floaterm_position = 'center'
let g:floaterm_winblend = 0
let g:floaterm_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
