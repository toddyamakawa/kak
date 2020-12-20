

# ==============================================================================
# ALT USER-MODE
# ==============================================================================
declare-user-mode alt
map global normal a ': enter-user-mode alt<ret>'
evaluate-commands %sh{
	printf "evaluate-commands %%{\n"
	for key in {a..z}; do
		printf "map global alt $key '<a-$key>' -docstring '<a-$key>'\n"
		printf "map global alt ${key^} '<a-${key^}>' -docstring '<a-${key^}>'\n"
	done
	printf "}\n"
}


# ==============================================================================
# NORMAL
# ==============================================================================
# <ret> to open command prompt
map global normal <ret> :

map global normal '#' ': comment-line<ret>' -docstring 'comment line'


# Unable to map <c-j>
# https://discuss.kakoune.com/t/arbitrary-keymaps-vs-terminals/942
#map global insert <c-j> <c-n>
#map global insert <c-k> <c-p>
#map global normal <c-j> 10j
#hook global RawKey <ret> %{ execute-keys -with-maps <c-j> }
#map global normal <c-k> 10k


# ==============================================================================
# INSERT
# ==============================================================================

# jj to exit
hook global InsertChar j %{ try %{
exec -draft hH <a-k>jj<ret> d
	exec <esc>
}}


# ==============================================================================
# VIEW
# ==============================================================================
map global view 'q' '<esc>'


