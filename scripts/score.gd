extends RichTextLabel


func updatetext(points: int) -> void:
	parse_bbcode ("\n[right]%s[img=40x40]res://100 Coins Icon.png[/img]" % [str(points)])
