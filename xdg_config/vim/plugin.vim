"" PATHOGEN {{{
" "call pathogen#incubate()
" let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'vim-snipmate')
" call add(g:pathogen_disabled, 'Smart-Tabs')
"
" call pathogen#infect('bundle/{}')
" "call pathogen#helptags() "call this when installing new plugins
" "call pathogen#infect()
"
"}}} end pathogen
"
" Vbundle {{{

" prolog {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" }}}

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" tpope {{{
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired.git'
" }}}

" ctrlp {{{
Plugin 'kien/ctrlp.vim.git'
" }}}
"
" tabular {{{
Plugin 'godlygeek/tabular.git'
" }}}

"virtualenv {{{
Plugin 'plytophogy/vim-virtualenv'
let g:virtualenv_directory = '~/.virtualenv'
" }}}

"syntastic {{{
Plugin 'vim-syntastic/syntastic'
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': [] }
" }}}

" vim-airline {{{
Plugin 'powerline/fonts' " Pre-patched and adjusted fonts for status line$
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"if exists("g:airline_theme_map")
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_theme = "powerlineish"
  let g:airline_section_gutter = "%= [%b:0x%B][hi:%{SyntaxItem()}]"
"endif
" }}}

" language support {{{
Plugin 'fatih/vim-go.git'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'pangloss/vim-javascript.git'
Plugin 'gabrielelana/vim-markdown.git'
Plugin 'octol/vim-cpp-enhanced-highlight' " Better C++ syntax highlighting
"Plugin 'rhysd/vim-clang-format' " Auto-format C++ files
" }}}

" color schemes {{{
Plugin 'chriskempson/base16-vim'
Plugin 'google/vim-colorscheme-primary.git'
Plugin 'altercation/vim-colors-solarized.git'
" }}}

" google-fmt {{{
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'
" }}}

Plugin 'bazelbuild/vim-bazel'
" editorconfig {{{
Plugin 'editorconfig/editorconfig-vim'
" }}}

" epilogue {{{
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" }}}
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}} end bundle

" Plugin settings {{{
" Glaive {{{
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
"" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
"Glaive codefmt plugin[mappings]
"Glaive codefmt clang_format_executable="clang-format-4.0"
"Glaive codefmt black_options=`['--line-length', '80']`
Glaive codefmt shfmt_options=`['-ci', '-sr', '-kp']`
" }}}

" }}}

" vim: fdm=marker
