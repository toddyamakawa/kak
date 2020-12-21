
# ==============================================================================
# COPY
# ==============================================================================
declare-option str 'clipboard_copy' %sh{
	case $(uname) in
		Linux)  echo "xclip -i";;
		Darwin) echo "pbcopy";;
	esac
}
# info "%opt{clipboard_copy}"
map global user P "!%opt{clipboard_paste}<ret>"     -docstring 'paste (before) from clipboard'
map global user p "<a-!>%opt{clipboard_paste}<ret>" -docstring 'paste (after) from clipboard'


# ==============================================================================
# PASTE
# ==============================================================================
# TODO: Implementpaste
declare-option str 'clipboard_paste' %sh{
	case $(uname) in
		Linux)  echo "xclip -o";;
		Darwin) echo "pbpaste";;
	esac
}
# info "%opt{clipboard_paste}"

# printf "map global user -docstring 'yank to primary' y '<a-|>%s<ret>:echo -markup %%{{information}copied selection to x11 primary}<ret>'\n" "$copy"
# printf "map global user -docstring 'yank to clipboard' y '<a-|>%s<ret>:echo -markup %%{{information}copied selection to x11 clipboard}<ret>'\n" "$copy -selection clipboard"
# printf "map global user -docstring 'replace from clipboard' r '|%s<ret>'\n" "$paste"

# hook global RegisterModified '"' %{ nop %sh{
# 	printf "%s "$kak_main_reg_dquote" | xclip -i
# }}

