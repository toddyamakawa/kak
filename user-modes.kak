
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
map global normal m ': enter-user-mode select-mode<ret>'
map global 'select-mode' p '<a-i>p: enter-user-mode -lock paragraph<ret>' -docstring 'paragraph'


# ==============================================================================
# PARAGRAPH
# ==============================================================================
declare-user-mode paragraph
map global paragraph d d -docstring 'delete'
map global paragraph y y -docstring 'yank'
map global paragraph L '>' -docstring 'move left'
map global paragraph H '<' -docstring 'move right'
map global paragraph q '<esc>'


