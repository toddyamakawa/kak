
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
# SETTINGS
# ==============================================================================
source "%val{config}/colorscheme.kak"

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


