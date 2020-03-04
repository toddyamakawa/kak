
# jj to exit
hook global InsertChar j %{ try %{
	exec -draft hH <a-k>jj<ret> d
	exec <esc>
}}

# <ret> to open command prompt
map global normal <ret> :

