
# map global normal O "<a-;>"

# ==============================================================================
# NORMAL
# ==============================================================================
# <ret> to open command prompt
map global normal <ret> :

# Searching
# Case-insensitive search by default
map global normal / /(?i)

# Comments
map global normal '#' ': comment-line<ret>' -docstring 'comment line'
map global normal '^' 's^<ret>'

# Macros
# Swap 'Q' and 'q' so I don't accidentally run a macro
map global normal q Q
map global normal Q q

# Register
map global normal R '"'

# HACK: Scrolling
# hook global RawKey <scroll:-?\d+> %{echo %val{key}}
# declare-option -hidden str prev_window_range
# hook -group win-scroll global NormalIdle .* %{
# 	evaluate-commands %sh{
# 		if [[ "$kak_window_range" != "$kak_opt_prev_window_range" ]]; then
# 			printf "%s\n" "execute-keys <c-l>"
# 			printf "%s\n" "set-option window prev_window_range '$kak_window_range'"
# 		fi
# 	}
# }
# remove-hooks global win-scroll
# hook global RawKey <scroll:-?\d+> %{exec <c-l>}
# hook global RawKey <scroll:-?\d+> %{echo %val{key}}
# hook global RawKey <scroll:-?\d+> %{echo %val{key}}

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


