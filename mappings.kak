
# ==============================================================================
# NORMAL
# ==============================================================================
# <ret> to open command prompt
map global normal <ret> :

# Comments
map global normal '#' ': comment-line<ret>' -docstring 'comment line'
map global normal '^' 's^<ret>'

# Macros
# Swap 'Q' and 'q' so I don't accidentally run a macro
map global normal q Q
map global normal Q q

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
map global view q '<esc>'


