"" FUNCTIONS {
function! SyntaxItem()
	return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! SortWords(sep)
	call setline('.', join(sort(split(getline('.'), a:sep)), a:sep))
endfunction
"" } end functions

