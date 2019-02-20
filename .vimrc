set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

nnoremap <f3> <C-w>-
nnoremap <f4> <C-w>+
nnoremap <f9> <C-w>>
nnoremap <f10> <C-w><
nnoremap <S-f12> :vsplit<bar>YcmCompleter GoTo<CR>
nnoremap <f12> :YcmCompleter GoTo<CR>
nnoremap <f11> :YcmCompleter FixIt<CR>

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'leafgarland/typescript-vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'tcnksm/gotests', { 'rtp': 'editor/vim' }
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'wellle/targets.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plugin 'junegunn/fzf.vim'
Plugin 'SirVer/ultisnips'

call vundle#end()            " required
filetype plugin indent on    " required

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:clang_format#code_style = 'google'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 1

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                         fzf#vim#with_preview('right', '?'),
  \                 <bang>0)

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1


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

set shiftwidth=2
