"" KEYMAPS {
" Insert/Command mode motions {
" : These mapping remove the urge to use the page up/down, home, etc for movement
" : remap alt-* combo to actual key in terminal mode
" : In terminal mode, <M-x> defaults to <esc>+x, which exits insert mode.
set timeout timeoutlen=1000 ttimeoutlen=100
if !has("gui_running")
	if &term == "xterm"
		set <M-0>=0
		set <M-b>=b
		set <M-d>=d
		set <M-$>=$
		set <M-f>=f
		set <M-h>=h
		set <M-j>=j
		set <M-k>=k
		set <M-l>=l
	en
en

" use Meta-j/k is mapped to <Up>/<Down> can be used for pum
if has("gui_running") || &term == "xterm"
	no! <M-0> <Home>
	no! <M-b> <PageUp>
	no! <M-d> <Del>
	no! <M-$> <End>
	no! <M-f> <PageDown>
	no! <M-h> <Left>
	no! <M-j> <Down>
	no! <M-k> <Up>
	no! <M-l> <Right>
en

" right exist of insert mode:
ino <silent> <S-esc> <esc>l

" nuke arrow key in insert mode
ino <Up> <Nop>
ino <Down> <Nop>
ino <Left> <Nop>
ino <Right> <Nop>

" Make arrow keys useful
no <Up> ddkP
no <Down> ddp
no <Left> <<
no <Right> >>
vm <Left> <gv
vm <Right> >gv

"" }
let mapleader=";"
" Buffer switch and kill {
" Create a new tab
nn <silent> <leader>nt :newtab
" Go to previous buffer
nn <silent> <leader>j :bprevious<cr>
nn <silent> <leader>tj :tabp<cr>
" Go to next buffer
nn <silent> <leader>k :bnext<cr>
nn <silent> <leader>tk :tabN<cr>
" Delete current buffer
nn <silent> <leader>dc :bdelete<cr>
nn <silent> <leader>dc! :bdelete!<cr>
" }
" Window motion {
" Create a vertical split
nn <silent> <leader>wv :vs<cr>
" Close current window
nn <silent> <leader>wc :clo<cr>
" Move the cursor to the window left of the current one
no <silent> <leader>wh :wincmd h<cr>
" Move the cursor to the window below the current one
no <silent> <leader>wj :wincmd j<cr>
" Move the cursor to the window above the current one
no <silent> <leader>wk :wincmd k<cr>
" Move the cursor to the window right of the current one
no <silent> <leader>wl :wincmd l<cr>
" } window motion
" editing and sourcing {g}vimrc {
" edit .vimrc
nn <silent> <leader>ev :e $MYVIMRC<cr>
nn <silent> <leader>gev :e $MYGVIMRC<cr>
" source .vimrc
nn <silent> <leader>sv :so $MYVIMRC<cr>:filetype detect<cr>
nn <silent> <leader>gsv :so $MYGVIMRC<cr>:filetype detect<cr>
" } source {g}vimrc
" Save and Exit {
" Make me!!
nn <silent> <leader>mm :!make<cr>
" run last command
nn <silent> <leader>rr :!<Up><cr>
" write
nn <silent> <leader>vw :w<cr>
nn <silent> <leader>vwa :wa<cr>
" equivalent to ZZ:
nn <silent> <leader>vwq :wq<cr>
"nnoremap <silent> <leader>vw! :w!<cr>
" quite
nn <silent> <leader>vq :q<cr>
nn <silent> <leader>vqa :qa<cr>
nn <silent> <leader>vq! :q!<cr>
" }
" Miscellaneous {
" toggle paste mode
nn <leader>sp :set paste!<cr>:set paste?<cr>
" toggle highlighted search
nn <leader>sh :set invhls<cr>:set hls?<cr>
" toggle list
nn <leader>sl :set list!<cr>:set list?<cr>
" toggle textwrap
nn <leader>sw :set wrap!<cr>:set wrap?<cr>
" retable entire file
nn <leader>rt :1,$retab<cr>
" cd to directory of current buffer
nn <leader>cd :lcd %:p:h<cr>
" display current directory
nn <leader>pwd :pwd<cr>
" } end misc
"" } end keymaps

