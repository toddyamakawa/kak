
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

