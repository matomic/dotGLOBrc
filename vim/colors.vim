"" COLOR SETTINGS {
"colo desert
" black background
if exists("syntax_on")
	syntax reset
endif
set background=dark
set t_Co=256
let g:solarized_termtrans  = 1
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
colorscheme solarized

" The main changes I make to the colours is make Function a tad brighter so
" it's more readable. Also, I prefer DarkCyan for my comments. I don't
" like comments to be "louder" than the actual code.
" This is a hack of the colour section in
" /usr/share/vim/syntax/syntax.vim

hi Folded       cterm=bold,reverse
hi Function     cterm=none             term=none
hi Normal       cterm=none             term=none
hi SpellBad     ctermfg=red            ctermbg=White         cterm=reverse
hi Statement    cterm=bold             term=none             gui=none
hi Todo         cterm=standout,bold    term=standout
hi Type         cterm=bold             term=none

hi Error   ctermbg=Red  ctermfg=White  guibg=Red guifg=White cterm=reverse term=reverse

if &background == "dark"
  " dark colors {
  hi Normal      ctermfg=LightGray   guifg=White
  "hi Comment     ctermfg=DarkBlue    guifg=Yellow      cterm=none      term=none
  "hi Constant    ctermfg=Magenta     guifg=Magenta     cterm=none      term=underline
  hi String      ctermfg=LightMagenta     guifg=Magenta
  "hi Function    ctermfg=LightGreen  guifg=LightRed    term=bold
  hi Function    ctermfg=LightGreen
  "hi Identifier  ctermfg=Cyan        guifg=#40ffff     cterm=bold      term=underline
  "hi Ignore      ctermfg=black
  "hi Operator    ctermfg=LightRed    guifg=Red
  "hi PreProc     ctermfg=Red         guifg=#ff80ff
  "hi Repeat      ctermfg=White       guifg=LightRed    term=underline
  "hi Special     ctermfg=Red         guifg=LightRed    term=bold
  "hi Statement   ctermfg=Green
  "hi Type        ctermfg=White       cterm=bold
  "hi Folded      ctermbg=LightGreen  ctermfg=DarkGray  guifg=Black
  "hi Todo        ctermbg=Red         ctermfg=Black     guifg=Blue      guibg=Yellow
  hi Tab         ctermbg=DarkBlue    guibg=grey30
  hi LeadSpace   ctermbg=Black       guibg=grey15
  hi link Space LeadSpace
  hi VertSplit   ctermbg=Yellow
  " }
else
  " bright colors {
  " hi Comment term=bold ctermfg=DarkBlue guifg=Blue
  " hi Constant term=underline ctermfg=DarkRed guifg=Magenta
  " hi Identifier term=underline ctermfg=DarkCyan guifg=DarkCyan
  " hi Ignore ctermfg=white guifg=bg
  " hi PreProc term=underline ctermfg=DarkMagenta guifg=Purple
  " hi Special term=bold ctermfg=DarkMagenta guifg=SlateBlue
  " hi Statement term=bold ctermfg=Brown guifg=Brown gui=bold
  " hi Type term=underline ctermfg=DarkGreen guifg=SeaGreen gui=bold
  " hi Folded ctermfg=White guifg=White
  hi Tab guibg=grey30 ctermbg=LightBlue
  hi LeadSpace guibg=grey15 ctermbg=LightGrey
  " }
endif
hi TrailSpace ctermbg=Red guibg=Red     

fu! AddMyMatches()
  let w:m1 = matchadd("Space"      , '\zs \+\ze[^ ]') |
  let w:m2 = matchadd("LeadSpace"  , '^\zs \+\ze[^ ]') |
  let w:m3 = matchadd("TrailSpace" , ' \+$') |
  let w:m4 = matchadd("Tab"        , '\t')
endf
call AddMyMatches()

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
"hi link String Constant
"hi link Character Constant
"hi link Number Constant
"hi link Boolean Constant
"hi link Float Number
"hi link Conditional Statement
"hi link Label Statement
"hi link Keyword Statement
"hi link Exception Statement
"hi link Include PreProc
"hi link Define PreProc
"hi link Macro PreProc
"hi link PreCondit PreProc
"hi link StorageClass Type
"hi link Structure Type
"hi link Typedef Type
hi link Debug Special
hi link Delimiter Special
hi link FoldColumn Folded
hi link SpecialChar Special
hi link SpecialComment Special
hi link Tag Special

"" } end color
