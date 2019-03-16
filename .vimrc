let g:ale_cpp_gcc_options = '-std=c++11 -Wall'
let &makeprg="(cd ~/code/build && make)"
let g:ale_echo_msg_format = 'ALE: [%linter%] %s [%severity%]'
let b:ale_linters = ['clang']
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow