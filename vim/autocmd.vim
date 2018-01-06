""  AUTOCOMMANDS {
"if has("autocmd")
"  " Enable file type detection, plugins, and indentation rules.
"  filetype plugin indent on
"
"  " reStructuredText (Python doctest) indent.
"  autocmd FileType rst setlocal sw=4 sts=4 et tw=72
"  " When editing a file, always jump to the last known cursor position.
"  autocmd BufReadPost *
"        \ if line("'\"") > 0 && line("'\"") <= line("$") |
"        \       execute "normal g`\"" |
"        \ endif
"endif
au VimEnter * au WinEnter * call AddSpaceHi()

" GNUPLOT: identify by header {
au BufRead *.gp[ih]\=
			\  if getline(1) =~ '^#!.*\/gnuplot$' |
			\    set ft=gnuplot |
			\ endif
" }

" Customize treatment for TeX {
" : virtual wrap except for comment
" : swap between screen line file line motion
" : turn on spell checking
au FileType tex,plaintex setlocal tw=0 spell lbr wrap fo=cl sw=2 ts=2 |
			\nnoremap <buffer> gj j|
			\nnoremap <buffer> j gj|
			\nnoremap <buffer> gk k|
			\nnoremap <buffer> k gk
au FileType bib setlocal ts=2 sw=2 noet spell lbr
" }

" Python {
" : not extent tab, shiftwidth=tabstop=4
au FileType python,pyrex setlocal ts=4 sw=4 sts=4 sta fdm=indent |
			\ setlocal nosmartindent nocindent |
			\ let python_highlight_all = 1
" }

" File types text width{
"au FileType python,cpp setlocal tw=150
" }

" File types custom syntax settings {
au FileType cuda syntax keyword cType hfloat dfloat
" }

" File types that prefer expanded tabs {
au FileType sh,lisp,python,pyrex,cpp,cuda setlocal et

" File types that prefer indentation amount 2
au FileType vim,sh setlocal noet ts=4 sw=4 sts=4
" }

" File types folding issue {
au FileType lua,sh setlocal fdm=marker
au FileType vim,xml,cpp,cuda setlocal fdm=syntax

" }

" coffeescript {
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
" }

" text-like filetypes {
au BufRead *.md set ft=markdown
au FileType gitcommit,markdown setlocal tw=150 spell lbr wrap
" }

"" } end au
"let javaScript_fold=1
