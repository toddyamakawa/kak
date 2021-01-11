
# ==============================================================================
# EXAMPLES
# ==============================================================================
# https://github.com/andreyorst/dotfiles/blob/187ebb84f9542b76a4f3c3e08f9533cd8187faa1/.config/kak/mnemonic-user-mode.kak


# ==============================================================================
# ALT
# ==============================================================================
declare-user-mode alt
map global normal v ': enter-user-mode alt<ret>'
# TODO: Use on-key %{}
evaluate-commands %sh{
	printf "evaluate-commands %%{\n"
	for key in {a..z}; do
		printf "map global alt $key '<a-$key>' -docstring '<a-$key>'\n"
		printf "map global alt ${key^} '<a-${key^}>' -docstring '<a-${key^}>'\n"
	done
	printf "}\n"
}


# ==============================================================================
# SELECT
# ==============================================================================
declare-user-mode select-mode
map global normal <space> ': enter-user-mode select-mode<ret>'
map global select-mode <space> <space> -docstring '<space>'


# ==============================================================================
# SPELL
# ==============================================================================
declare-user-mode spell
define-command enter-spell-mode %{
	spell
	enter-user-mode spell
}
map global select-mode s ': enter-spell-mode<ret>'          -docstring 'spell'
map global spell a ': spell-add; enter-spell-mode<ret>'     -docstring 'add to dictionary'
map global spell n ': spell-next; enter-spell-mode<ret>'    -docstring 'next misspelling'
map global spell r ': spell-replace; enter-spell-mode<ret>' -docstring 'suggest replacement'
# Hook this comment: https://discuss.kakoune.com/t/mode-hooks-and-user-modes/169/6
hook global ModeChange push:[^:]*:next-key\[user.spell\] %{
	hook -once -always window NormalIdle .* spell-clear
}


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


