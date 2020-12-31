
# ==============================================================================
# ALT
# ==============================================================================
declare-user-mode alt
map global normal v ': enter-user-mode alt<ret>'
evaluate-commands %sh{
	printf "evaluate-commands %%{\n"
	for key in {a..z}; do
		printf "map global alt $key '<a-$key>' -docstring '<a-$key>'\n"
		printf "map global alt ${key^} '<a-${key^}>' -docstring '<a-${key^}>'\n"
	done
	printf "}\n"
}


# ==============================================================================
# SELECT-MODE
# ==============================================================================
declare-user-mode select-mode
map global normal <space> ': enter-user-mode select-mode<ret>'
map global select-mode <space> <space> -docstring '<space>'


# ==============================================================================
# PARAGRAPH
# ==============================================================================
declare-user-mode paragraph
declare-option str 'paragraph_select' '<a-a>pj[p'
map global select-mode p "%opt{paragraph_select}: enter-user-mode -lock paragraph<ret>" -docstring 'paragraph'
map global paragraph L '>'                              -docstring 'move left'
map global paragraph H '<'                              -docstring 'move right'
map global paragraph K "d[pP[p%opt{paragraph_select}"   -docstring 'move up'
map global paragraph J "d]pp]p[p%opt{paragraph_select}" -docstring 'move down'
map global paragraph j "]p%opt{paragraph_select}"       -docstring 'select down'
map global paragraph k "[p%opt{paragraph_select}"       -docstring 'select up'
map global paragraph d "d%opt{paragraph_select}"        -docstring 'delete'
map global paragraph y y                                -docstring 'yank'
map global paragraph q '<esc>'


# ==============================================================================
# LINE
# ==============================================================================
declare-user-mode line
map global select-mode l 'gllGh: enter-user-mode -lock line<ret>' -docstring 'line'
map global line H '<'          -docstring 'move right'
map global line J "dpjgllGh"   -docstring 'move down'
map global line K 'dkkpjgllGh' -docstring 'move up'
map global line L '>'          -docstring 'move left'
map global line j 'jgllGh'     -docstring 'select down'
map global line k 'kgllGh'     -docstring 'select up'
map global line d d            -docstring 'delete'
map global line y y            -docstring 'yank'
map global line q '<esc>'


