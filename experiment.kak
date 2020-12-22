
# ==============================================================================
# EXTEND
# ==============================================================================
define-command map-extend -params 1 %{
	evaluate-commands %sh{
		key="$1"
		printf "%s\n" "map global normal ${key,} ${key^}"
		printf "%s\n" "map global normal ${key^} <a-${key^}>"
	}
}

map-extend b
map-extend e
map-extend f
#map-extend g
map-extend n
map-extend t
map-extend w

# map global normal <space> lh<space>
# map global normal g G



