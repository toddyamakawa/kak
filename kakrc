
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
# SETTINGS
# ==============================================================================

#hook global WinCreate .* addhl show-whitespaces

# Highlight trailing whitspace
add-highlighter global/show-trailing-whitespace regex '\h+$' 0:Error

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

