# https://raw.githubusercontent.com/JJK96/kakoune-config/master/autoload/wordcount.kak
define-command wordcount %{
	evaluate-commands %sh{
		words=$(echo "$kak_selection" | wc -w)
		lines=$(echo "$kak_selection" | wc -l)
		echo "info %{$words words"
		echo "$lines lines"
		echo "}"
	}
}
