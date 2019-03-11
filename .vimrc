let g:ale_cpp_gcc_options = '-std=c++11 -Wall'
let &makeprg="(cd ~/code/build && make)" 
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
