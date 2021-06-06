
# ==============================================================================
# NORMAL MODE
# ==============================================================================
#map global normal V ': enter-user-mode vim-normal<ret>'
try %{ declare-user-mode vim-normal }
#map global vim-normal v ': enter-user-mode -lock vim-visual<ret>' -docstring 'visual mode'
map global vim-normal v ': enter-user-mode vim-visual<ret>' -docstring 'visual mode'
map global vim-normal a 'lha'
map global vim-normal n n
map global vim-normal N '<a-n>'
map global vim-normal q ': fail<ret>'  -docstring 'quit'


# ==============================================================================
# VISUAL MODE
# ==============================================================================
try %{ declare-user-mode vim-visual }
define-command enter-vim-visual-mode -params 0 -docstring 'enter vim-visual mode' %{
	enter-user-mode vim-visual
}
#map global normal v ': enter-vim-visual-mode<ret>'
map global normal v ': enter-vim-visual-mode<ret>'

# e.g.
# $> vim-map-visual-both n
# map global vim-visual n N
# map global vim-visual N <a-N>
define-command vim-map-visual-both -params 1 %{
	evaluate-commands %sh{
		key="$1"
		printf "%s\n" "map global vim-visual ${key,} '${key^}: enter-vim-visual-mode<ret>'"
		printf "%s\n" "map global vim-visual ${key^} '<a-${key^}>: enter-vim-visual-mode<ret>'"
	}
}

# define-command vim-map-visual -params 1 %{

# Selection
map global vim-visual a <a-a> -docstring 'select surrounding object'
map global vim-visual i <a-i> -docstring 'select inner object'

# Commands
map global vim-visual u ` -docstring 'lowercase'
map global vim-visual U ~ -docstring 'uppercase'

# Navigation
# HACK: Implemented like this  until this GitHub issue is fixed:
# https://github.com/mawww/kakoune/issues/3753
map global vim-visual h 'H:     enter-vim-visual-mode<ret>'
map global vim-visual H 'Gh:    enter-vim-visual-mode<ret>'
map global vim-visual j 'J:     enter-vim-visual-mode<ret>'
#map global vim-visual J 'C:     enter-vim-visual-mode<ret>'
map global vim-visual k 'K:     enter-vim-visual-mode<ret>'
#map global vim-visual K '<a-C>: enter-vim-visual-mode<ret>'
map global vim-visual l 'L:     enter-vim-visual-mode<ret>'
map global vim-visual L 'Gl:    enter-vim-visual-mode<ret>'
map global vim-visual o '<a-semicolon>: enter-vim-visual-mode<ret>'  -docstring 'otherside'

vim-map-visual-both b
vim-map-visual-both e
vim-map-visual-both f
#vim-map-visual-both g
vim-map-visual-both n
vim-map-visual-both t
vim-map-visual-both w

# map global normal <space> lh<space>
# map global normal g G

# Command and quit
map global vim-visual r 'r' -docstring 'replace'
map global vim-visual c 'c' -docstring 'change'
map global vim-visual d 'd' -docstring 'delete'
map global vim-visual y 'y' -docstring 'yank'
map global vim-visual <space> ''  -docstring 'leave'

