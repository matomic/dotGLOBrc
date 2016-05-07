"" FUNCTIONS {
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction
"" } end functions

