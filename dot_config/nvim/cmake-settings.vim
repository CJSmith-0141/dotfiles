let g:cmake_default_config='build'
let g:cmake_link_compile_commands=1
let g:cmake_console_size=10
nnoremap <leader>cl :CMakeSwitch cmake-debug-clang<CR>
nnoremap <leader>cg :CMakeSwitch build<CR>
nnoremap <leader>cc :CMakeGenerate<CR>
nnoremap <leader>cb :CMakeBuild -j4<CR>
nnoremap <leader>cq :CMakeClose<CR>
nnoremap <leader>co :CMakeOpen<CR>
