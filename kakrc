
# ==============================================================================
# PLUGINS
# ==============================================================================
declare-option -docstring "plug.kak" str plugkak "%val{config}/plugins/plug.kak/rc/plug.kak"

# Source and/or automatically install plug.kak
try %{
	source "%opt{plugkak}"
} catch %sh{
	if [[ ! -d "$kak_config/plugins/plug.kak" ]]; then
		git clone "https://github.com/robertmeta/plug.kak.git" "$kak_config/plugins/plug.kak"
		echo "source '%opt{plugkak}'"
	fi
}


plug 'kak-lsp/kak-lsp' config %{
	cargo install --locked --force --path .
	evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}
	lsp-enable
}


# ==============================================================================
# COLORS
# ==============================================================================

set-face global Default 'rgb:d0d0d0,rgb:101010'

add-highlighter global/ number-lines -separator '│ '
set-face global LineNumbers 'rgb:505050,default'

# Whitepace characters
# https://discuss.kakoune.com/t/see-unwanted-characters/843

add-highlighter global/ show-whitespaces
#set-face global Whitespace 'rgb:505050,rgb:303030'
set-face global Whitespace 'default,default'

# Highlight trailing whitspace
hook global WinSetOption filetype=.* %{
	add-highlighter window/trailing-whitespace regex '\h+$' 0:Error
	add-highlighter window/newline regex '\n+' "0:rgb:505050"
	add-highlighter window/whitespace regex '\h+' "0:rgb:505050"
}


# ==============================================================================
# SETTINGS
# ==============================================================================

set-option global tabstop 4
set-option global indentwidth 0

set global scrolloff '3,7'


# ==============================================================================
# MAPPINGS
# ==============================================================================

# jj to exit
hook global InsertChar j %{ try %{
	exec -draft hH <a-k>jj<ret> d
	exec <esc>
}}

# <ret> to open command prompt
map global normal <ret> :

