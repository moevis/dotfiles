let g:ale_echo_msg_format = 'ALE: [%linter%] %s [%severity%]'
let g:ale_linters = { 'cpp': ['clang'] }
let g:ale_cpp_clang_options="-std=c++11 -Wall"
let &makeprg="(cd build && make -j4)"

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
