
# ==============================================================================
# EXAMPLES
# ==============================================================================
# Default color scheme:
# https://github.com/mawww/kakoune/blob/master/colors/default.kak


# ==============================================================================
# PALETTE
# ==============================================================================
declare-option str 'black'     'rgb:181818'
declare-option str 'gray'      'rgb:505050'
declare-option str 'white'     'rgb:f0f0f0'
declare-option str 'red'       'rgb:ff8080'
declare-option str 'orange'    'rgb:ffa080'
declare-option str 'yellow'    'rgb:f0f090'
declare-option str 'green'     'rgb:90f090'
declare-option str 'blue'      'rgb:9090f0'
declare-option str 'blue_dark' 'rgb:4040f0'
declare-option str 'cyan'      'rgb:90f0f0'
declare-option str 'purple'    'rgb:c090f0'
declare-option str 'pink'      'rgb:ffa0d0'


# ==============================================================================
# FACES
# ==============================================================================
# Builtin ----------------------------------------------------------------------
set-face global Default            "%opt{white},%opt{black}"
set-face global PrimaryCursor      "%opt{black},%opt{white}"
set-face global PrimarySelection   "%opt{white},%opt{blue_dark}"
set-face global PrimaryCursorEol   "%opt{black},%opt{white}"
set-face global SecondaryCursor    "%opt{black},%opt{white}"
set-face global SecondarySelection "%opt{white},%opt{blue_dark}"
set-face global SecondaryCursorEol "%opt{black},%opt{white}"
set-face global Error              "%opt{black},%opt{red}"

# https://github.com/mawww/kakoune/wiki/Status-line
# Default: %val{bufname} %val{cursor_line}:%val{cursor_char_column} {{context_info}} {{mode_info}} - %val{client}@[%val{session}]
# TODO: Add scrollbar
# TODO: Add percentage position
# TODO: Git integration?
declare-option str 'modeline_pos' '{%opt{yellow},%opt{gray}+b}%val{cursor_line},%val{cursor_char_column}{default,default}'
declare-option str 'modeline_bufname' '{%opt{white}+b}[%val{bufname}]{%opt{cyan}+b}[%opt{filetype}]{default,default}'
declare-option str 'modeline_session' '{%opt{purple}}[%val{client}@%val{session}]{default,default}'
set global modelinefmt "%opt{modeline_pos} {{mode_info}} %opt{modeline_bufname}{{context_info}}%opt{modeline_session}"

set-face global StatusCursor    "%opt{black},%opt{white}"
set-face global StatusLine      "%opt{cyan},%opt{gray}"
set-face global StatusLineInfo  "%opt{green}+b"
set-face global StatusLineMode  "%opt{gray},%opt{yellow}+b"
set-face global StatusLineValue "%opt{gray},%opt{cyan}+b"

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
set-face global Information "%opt{pink},rgb:404040"

# EOF tildas
set-face global BufferPadding 'rgb:505050,default'


# ==============================================================================
# HIGHLIGHTERS
# ==============================================================================
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
	add-highlighter window/ansi regex '\[[;0-9]+m' '0:Whitespace'
}

# MACROS, Names, g_, specific strings
add-highlighter global/ regex '\b[A-Z][_0-9A-Z]+\b' "0:%opt{purple}+b"
add-highlighter global/ regex '\b_*([A-Z][_a-z]+)+\b' "0:%opt{purple}"
add-highlighter global/ regex '\bg_\w+\b' "0:%opt{purple}"
add-highlighter global/ regex '\b(DEBUG|INFO|Info)\b' "0:%opt{cyan}+b"
add-highlighter global/ regex '(?S)^.*(ERROR|FATAL|CRITICAL).*$' "0:%opt{red}+b"
add-highlighter global/ regex '\b(TODO|REVISIT|FIXME|HACK|XXX|NOTE)\b' '0:default+rb'

# function() definitions and calls
add-highlighter global/ regex '^\s*def\s+(\w+)' "1:%opt{yellow}"
add-highlighter global/ regex '\b(\w+)\(' "1:%opt{yellow}"
add-highlighter global/ regex '(\w+)(\.\w+)+' "1:%opt{orange}"
add-highlighter global/ regex '(\w+)(\.\w+)+' "2:%opt{yellow}"

# Numbers
add-highlighter global/ regex '\b(\d{1,3})(\d{3})+\b' "1:default+b"
add-highlighter global/ regex '\b\d+\b' "0:%opt{red}"
add-highlighter global/ regex '\b(0x)?[_0-9a-fA-F]{4,}\b' "0:%opt{red}"

# Searching
add-highlighter global/ dynregex '%reg{/}' '0:+u'
# TODO: Highlight word under cursor
# https://github.com/mawww/config/blob/d841453cc71f3ab8cbe19ac5036cd86807590617/kakrc#L40-L54


# ==============================================================================
# DYNAMIC COLORS
# ==============================================================================
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

