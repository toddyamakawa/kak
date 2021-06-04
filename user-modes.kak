
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
# CHOOSE
# ==============================================================================
declare-user-mode choose-mode
map global normal <space> ': enter-user-mode choose-mode<ret>'
map global choose-mode <space> <space> -docstring '<space>'
map global choose-mode <semicolon> '<space><semicolon>' -docstring '<space><semicolon>'


# ==============================================================================
# SPELL
# ==============================================================================
# TODO: Define a genric "map" and "reenter mode" command
declare-user-mode spell
define-command enter-spell-mode %{
	spell
	enter-user-mode spell
}
map global choose-mode s ': enter-spell-mode<ret>'          -docstring 'spell'
map global spell a ': spell-add; enter-spell-mode<ret>'     -docstring 'add to dictionary'
map global spell n ': spell-next; enter-spell-mode<ret>'    -docstring 'next misspelling'
map global spell r ': spell-replace; enter-spell-mode<ret>' -docstring 'suggest replacement'
# Hook this comment: https://discuss.kakoune.com/t/mode-hooks-and-user-modes/169/6
hook global ModeChange push:[^:]*:next-key\[user.spell\] %{
	hook -once -always window NormalIdle .* spell-clear
}


# ==============================================================================
# SELECT
# ==============================================================================
declare-user-mode select
map global choose-mode s ": enter-user-mode -lock select<ret>" -docstring 'select'
map global select j ')'                 -docstring 'next'
map global select k '('                 -docstring 'previous'
map global select d '<a-space>'         -docstring 'delete'
map global select <space> ': fail<ret>' -docstring 'leave'


# ==============================================================================
# PARAGRAPH
# ==============================================================================
declare-user-mode paragraph
declare-option str 'paragraph_select' ']pj[p'
map global choose-mode p ": enter-user-mode -lock paragraph<ret>" -docstring 'paragraph'
map global paragraph j "]pj"                                -docstring 'select down'
map global paragraph k "[p;"                                -docstring 'select up'
map global paragraph L "%opt{paragraph_select}>;"           -docstring 'move left'
map global paragraph H "%opt{paragraph_select}<;"           -docstring 'move right'
map global paragraph K "%opt{paragraph_select}d[pP[p;"      -docstring 'move up'
map global paragraph J "%opt{paragraph_select}d]pp]p[p;"    -docstring 'move down'
map global paragraph d "%opt{paragraph_select}d"            -docstring 'delete'
map global paragraph y "%opt{paragraph_select}y"            -docstring 'yank'
map global paragraph v "%opt{paragraph_select}: fail <ret>" -docstring 'select'
map global paragraph <space> ': fail<ret>'                  -docstring 'leave'


# ==============================================================================
# LINE
# ==============================================================================
declare-user-mode line
map global choose-mode l 'gh: enter-user-mode -lock line<ret>' -docstring 'line'
map global line j 'jgh'    -docstring 'select down'
map global line k 'kgh'    -docstring 'select up'
map global line L '>'      -docstring 'move left'
map global line H '<'      -docstring 'move right'
map global line K 'xdkkpj' -docstring 'move up'
map global line J 'xdpj'   -docstring 'move down'
map global line d 'xd'     -docstring 'delete'
map global line y 'xygh'   -docstring 'yank'
map global line <space> ': fail<ret>' -docstring 'leave'


# ==============================================================================
# BUFFER
# ==============================================================================
declare-user-mode buffer
map global choose-mode f ': enter-user-mode -lock buffer<ret>' -docstring 'buffer'
map global buffer j ': buffer-next<ret>'     -docstring 'buffer-next'
map global buffer k ': buffer-previous<ret>' -docstring 'buffer-previous'
map global buffer h 'gk'                     -docstring 'top'
map global buffer l 'gj'                     -docstring 'bottom'
map global buffer d ': delete-buffer<ret>'   -docstring 'delete-buffer'
map global buffer x ': write-quit!<ret>'     -docstring 'write-quit!'
map global buffer w ': write<ret>'           -docstring 'write'
map global buffer q ': quit!<ret>'           -docstring 'quit!'
#TODO: map s to run '%s'
map global buffer <space> ': fail<ret>'      -docstring 'leave'

