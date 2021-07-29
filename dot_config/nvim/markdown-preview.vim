augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
    autocmd FileType markdown set conceallevel=0
    autocmd FileType markdown normal zR
augroup END

let g:vim_markdown_frontmatter=1

let g:mkdp_markdown_css='/home/csmith/.github-markdown.css'
