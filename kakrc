
# ==============================================================================
# SETUP
# ==============================================================================
nop %sh{
	if [[ ! -d "$kak_config/autoload/default" ]]; then
		kakdir="$(dirname "$(dirname "$(which kak)")")"
		ln -s "$kakdir/share/kak/autoload" "$kak_config/autoload/default"
	fi
}


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
# Default color scheme:
# https://github.com/mawww/kakoune/blob/master/colors/default.kak

# Color palette
declare-option str 'black'     'rgb:181818'
declare-option str 'gray'      'rgb:505050'
declare-option str 'white'     'rgb:f0f0f0'
declare-option str 'red'       'rgb:ff8080'
declare-option str 'orange'    'rgb:ffb060'
declare-option str 'yellow'    'rgb:f0f090'
declare-option str 'green'     'rgb:50f080'
declare-option str 'blue'      'rgb:9090f0'
declare-option str 'blue_dark' 'rgb:4040f0'
declare-option str 'cyan'      'rgb:90f0f0'
declare-option str 'purple'    'rgb:c090f0'
declare-option str 'pink'      'rgb:ff79c6'

# Builtin faces
set-face global Default            "%opt{white},%opt{black}"
set-face global PrimaryCursor      "%opt{black},%opt{white}"
set-face global PrimarySelection   "%opt{white},%opt{blue_dark}"
set-face global PrimaryCursorEol   "%opt{black},%opt{white}"
set-face global SecondaryCursor    "%opt{black},%opt{white}"
set-face global SecondarySelection "%opt{white},%opt{blue_dark}"
set-face global SecondaryCursorEol "%opt{black},%opt{white}"
set-face global Error              "%opt{black},%opt{red}"

# Code -------------------------------------------------------------------------
set-face global attribute "%opt{yellow}"
# echo
set-face global builtin   "%opt{blue}+b"
set-face global comment   'rgb:707070'
set-face global identifier "%opt{red}"
set-face global function  "%opt{red}+b"
set-face global keyword   "%opt{cyan}"
# #include <...>
set-face global meta      "%opt{cyan}"
# <stdlib.h>
set-face global module    "%opt{red}+b"
set-face global operator  "%opt{orange}"
set-face global string    "%opt{green}"
set-face global value     "%opt{green}"
set-face global variable  "%opt{red}"
set-face global type      "%opt{purple}"

set-face global MatchingChar "%opt{orange}"

# Markup -----------------------------------------------------------------------
# set-face global title "%opt{red}+b"
set-face global header "%opt{yellow}+b"
# set-face global italic "%opt{green}"
# set-face global bold "%opt{green}"
set-face global mono "%opt{green}"
set-face global block "%opt{green}"
set-face global link "%opt{purple}"
set-face global bullet "%opt{orange}"
set-face global list "%opt{orange}+b"

# Menu/completion
set-face global MenuForeground "rgb:606060,%opt{yellow}"
set-face global MenuBackground "%opt{yellow},rgb:606060"
set-face global MenuInfo       "%opt{yellow},rgb:606060"

# Assistant/[+]
set-face global Information "%opt{green},rgb:404040"

# Line numbers
# :addhl window wrap
add-highlighter global/ number-lines \
	-separator '│ '                  \
	-relative                        \
	-hlcursor                        \
	-min-digits 3
set-face global LineNumbers        'rgb:505050,default'
set-face global LineNumbersWrapped 'rgb:202020,default'
set-face global LineNumberCursor   "%opt{yellow},default"

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

# MACROS, Names, g_, specific strings
add-highlighter global/ regex '\b[A-Z][_0-9A-Z]+\b' "0:%opt{orange}+b"
add-highlighter global/ regex '\b_*([A-Z][_a-z]+)+\b' "0:%opt{orange}"
add-highlighter global/ regex '\bg_\w+\b' "0:%opt{orange}"
add-highlighter global/ regex '\b(DEBUG|INFO|Info)\b' "0:%opt{cyan}+b"
add-highlighter global/ regex '\b(ERROR|FATAL|CRITICAL)\b' "0:%opt{red}+b"
add-highlighter global/ regex '\b(TODO|REVISIT|FIXME|HACK|XXX|NOTE)\b' '0:default+rb'

# function() definitions and calls
add-highlighter global/ regex '^\s*def\s+(\w+)' "1:%opt{yellow}"
add-highlighter global/ regex '\b(\w+)\(' "1:%opt{yellow}"
add-highlighter global/ regex '\.(\w+)' "1:%opt{yellow}"

# Numbers
add-highlighter global/ regex '\b(\d{1,3})(\d{3})+\b' "1:default+b"
add-highlighter global/ regex '\b\d+\b' "0:%opt{red}"
add-highlighter global/ regex '\b(0x)?[_0-9a-fA-F]{4,}\b' "0:%opt{red}"

# Searching
add-highlighter global/ dynregex '%reg{/}' '0:+u'

# EOF tildas
set-face global BufferPadding 'rgb:505050,default'

# Current row
# https://github.com/insipx/kak-crosshairs/blob/master/crosshairs.kak
set-face global line 'default,rgb:303030+bd'
define-command -hidden highlight-line -docstring "Highlight current line" %{
    try %{ remove-highlighter window/line }
    try %{ add-highlighter window/line line %val{cursor_line} line }
}
hook global RawKey .+ highlight-line

# Focus events
hook global FocusIn .* %{
	set-face global Default "%opt{white},%opt{black}"
}
hook global FocusOut .* %{
	set-face global Default 'rgb:c0c0c0,rgb:000000'
}

# TODO: Create statusbar scrollbar
# %val{window_range}
# list of coordinates and dimensions of the buffer-space available on the current window
# format: <coord_x> <coord_y> <width> <height>


# ==============================================================================
# SETTINGS
# ==============================================================================

set-option global tabstop 4
set-option global indentwidth 0

set-option global scrolloff '3,7'

# Assistant (clippy, cat, dilbert, none)
set-option global ui_options ncurses_assistant=cat


# ==============================================================================
# ALIASES/COMMANDS
# ==============================================================================

alias global bd delete-buffer


#define-command -params 1 -file-completion -docstring 'executes mkdir -p' mkdir %{
#	nop %sh{ mkdir -p "$1" }
#}
define-command do -docstring 'Evaluate selection' %{
	eval %val{selection}
}
define-command sbf -docstring 'set buffer filetype' -params .. %{
	set buffer filetype %arg{@}
}


# ==============================================================================
# MAPPINGS
# ==============================================================================
#debug mappings
source "%val{config}/mappings.kak"
source "%val{config}/user-modes.kak"


