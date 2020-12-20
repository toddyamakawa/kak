
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

# TODO: https://github.com/enricozb/tabs.kak


# ==============================================================================
# COLORS
# ==============================================================================

# Line numbers
set-face global Default 'rgb:d0d0d0,rgb:101010'
add-highlighter global/ number-lines \
	-separator '│ '                  \
	-relative                        \
	-hlcursor                        \
	-min-digits 3
set-face global LineNumbers 'rgb:606060,default'
set-face global LineNumbersWrapped 'rgb:303030,default'
set-face global LineNumberCursor 'yellow,default'

# Show whitepace characters
# https://discuss.kakoune.com/t/see-unwanted-characters/843
add-highlighter global/ show-whitespaces \
	-lf '⇣'                              \
	-spc '·'                             \
	-tab '▸'
set-face global Whitespace 'rgb:505050,default'

hook global WinSetOption filetype=.* %{
	add-highlighter window/trailing-whitespace regex '\h+$' 0:Error
	add-highlighter window/newline regex '\n+' "0:Whitespace"
	add-highlighter window/whitespace regex '\h+' "0:Whitespace"
}


# ==============================================================================
# SETTINGS
# ==============================================================================

set-option global tabstop 4
set-option global indentwidth 0

set global scrolloff '3,7'


# ==============================================================================
# ALIASES/COMMANDS
# ==============================================================================

alias global bd delete-buffer

#define-command -params 1 -file-completion -docstring 'executes mkdir -p' mkdir %{
#	nop %sh{ mkdir -p "$1" }
#}
define-command do %{ eval %val{selection} }


# ==============================================================================
# MAPPINGS
# ==============================================================================
#debug mappings
source "%val{config}/mappings.kak"



