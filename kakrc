
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


# plug 'kak-lsp/kak-lsp' config %{
# 	cargo install --locked --force --path .
# 	evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}
# 	lsp-enable
# }

plug 'delapouite/kakoune-palette'

# TODO: https://github.com/enricozb/tabs.kak


# ==============================================================================
# COLORS
# ==============================================================================
# Color palette
declare-option str 'black'  'rgb:282a36'
declare-option str 'gray'   'rgb:44475a'
declare-option str 'white'  'rgb:f8f8f2'
declare-option str 'red'    'rgb:ff5555'
declare-option str 'orange' 'rgb:ffb060'
declare-option str 'yellow' 'rgb:f0f090'
declare-option str 'green'  'rgb:50f080'
declare-option str 'blue'   'rgb:6272a4'
declare-option str 'cyan'   'rgb:90f0f0'
declare-option str 'purple' 'rgb:c090f0'
declare-option str 'pink'   'rgb:ff79c6'

# Builtin faces
set-face global Default 'rgb:d0d0d0,rgb:101010'

set-face global attribute "%opt{green}"
set-face global comment   'rgb:707070'
set-face global keyword   "%opt{cyan}"
set-face global operator  "%opt{orange}"
set-face global string    "%opt{yellow}"
set-face global value     "%opt{green}"
set-face global type      "%opt{purple}"

#set-face global builtin "%opt{white}+b"
#set-face global function "%opt{red}"
#set-face global meta "%opt{red}"
#set-face global module "%opt{red}"
#set-face global variable "%opt{red}"

# Menu/Completion
set-face global MenuForeground "rgb:404040,%opt{yellow}"
set-face global MenuBackground "%opt{yellow},rgb:404040"
set-face global MenuInfo "%opt{yellow},rgb:404040"

# Assistant
set-face global Information "%opt{green},rgb:404040"

# Line numbers
add-highlighter global/ number-lines \
	-separator '│ '                  \
	-relative                        \
	-hlcursor                        \
	-min-digits 3
set-face global LineNumbers 'rgb:505050,default'
set-face global LineNumbersWrapped 'rgb:202020,default'
set-face global LineNumberCursor "%opt{yellow},default"

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

set-option global scrolloff '3,7'


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

