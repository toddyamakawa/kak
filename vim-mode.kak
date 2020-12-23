

# ==============================================================================
# NORMAL MODE
# ==============================================================================
declare-user-mode vim-normal-mode
map global vim-normal-mode v ': enter-user-mode -lock vim-visual-mode<ret>' -docstring 'visual mode'
map global vim-normal-mode a 'lha'
map global vim-normal-mode n n
map global vim-normal-mode N '<a-n>'


# ==============================================================================
# VISUAL MODE
# ==============================================================================
declare-user-mode vim-visual-mode
map global normal v ': enter-user-mode vim-visual-mode<ret>'

# e.g.
# map-visual n
# map global vim-visual-mode n N
# map global vim-visual-mode N <a-N>
define-command vim-map-visual -params 1 %{
	evaluate-commands %sh{
		key="$1"
		printf "%s\n" "map global vim-visual-mode ${key,} ${key^}"
		printf "%s\n" "map global vim-visual-mode ${key^} <a-${key^}>"
	}
}

map-visual e
map-visual f
#map-visual g
map-visual n
map-visual t
map-visual w

# map global normal <space> lh<space>
# map global normal g G

