extends Panel
@onready var line_edit: LineEdit = $LineEdit
@onready var game_manager: Node = %"Game Manager"
var time = Global.time
var playerName:String


func _on_line_edit_text_submitted(_new_text: String) -> void:
	line_edit.editable = false
	playerName = line_edit.text
	line_edit.text = "Submitted"
	Global.playerName = playerName
	print(playerName)
	print(time)
	await Leaderboards.post_guest_score("100-coins-time-kK2Y", time, playerName)
	Global.submitted = true


func _on_play_again_button_up() -> void:
	get_tree().reload_current_scene()
