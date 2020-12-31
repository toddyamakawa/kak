
# ==============================================================================
# REFERENCE
# ==============================================================================
# https://discuss.kakoune.com/t/special-key-codes/1506
#
# Return    -> ret
# Space     -> space
# Tab       -> tab
# <         -> lt
# >         -> gt
# Backspace -> backspace
# Escape    -> esc
# Up        -> up
# Down      -> down
# Left      -> left
# Right     -> right
# Page Up   -> pageup
# Page Down -> pagedown
# Home      -> home
# End       -> end
# Insert    -> ins
# Delete    -> del
# +         -> plus
# -         -> minus
# ;         -> semicolon
# %         -> percent


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

# Marks
# declare-user-mode set-mark
# map global normal M ': enter-user-mode set-mark<ret>'
# map global set-mark a ': set-mark a<ret>'
# define-command set-mark -docstring "set-mark [<register>]: save selection to <register>" -params 1 %{
# 	execute-keys %sh{ echo '"'"$1"Z }
# }
# declare-user-mode restore-mark
# map global normal m ': enter-user-mode restore-mark<ret>'
# map global restore-mark a ': restore-mark a<ret>'
# define-command restore-mark -docstring "restore-mark [<register>]: restore selection from <register>" -params 1 %{
# 	execute-keys %sh{ echo '"'"$1"z }
# }

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


# map global normal "<a-lt>" x

