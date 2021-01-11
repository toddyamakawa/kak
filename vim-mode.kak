
# Can't implement Vim user-mode until this GitHub issue if fixed:
# https://github.com/mawww/kakoune/issues/3753

# ==============================================================================
# NORMAL MODE
# ==============================================================================
#map global normal V ': enter-user-mode vim-normal-mode<ret>'
try %{ declare-user-mode vim-normal-mode }
#map global vim-normal-mode v ': enter-user-mode -lock vim-visual-mode<ret>' -docstring 'visual mode'
map global vim-normal-mode a 'lha'
map global vim-normal-mode n n
map global vim-normal-mode N '<a-n>'


# ==============================================================================
# VISUAL MODE
# ==============================================================================
try %{ declare-user-mode vim-visual-mode }
#map global normal v ': enter-user-mode -lock vim-visual-mode<ret>'

# e.g.
# $> map-visual n
# map global vim-visual-mode n N
# map global vim-visual-mode N <a-N>
define-command vim-map-visual -params 1 %{
	evaluate-commands %sh{
		key="$1"
		printf "%s\n" "map global vim-visual-mode ${key,} ${key^}"
		printf "%s\n" "map global vim-visual-mode ${key^} <a-${key^}>"
	}
}

#map global vim-visual-mode a <a-a> -docstring 'select surrounding object'
#map global vim-visual-mode i <a-i> -docstring 'select inner object'

# Commands
map global vim-visual-mode u ` -docstring 'lowercase'
map global vim-visual-mode U ~ -docstring 'uppercase'
map global vim-visual-mode o <a-semicolon> -docstring 'otherside'

# Navigation
map global vim-visual-mode h H
map global vim-visual-mode H Gh
map global vim-visual-mode j J
map global vim-visual-mode J C
map global vim-visual-mode k K
map global vim-visual-mode K <a-C>
map global vim-visual-mode l L
map global vim-visual-mode L Gl

vim-map-visual e
vim-map-visual f
#vim-map-visual g
vim-map-visual n
vim-map-visual t
vim-map-visual w

# map global normal <space> lh<space>
# map global normal g G

