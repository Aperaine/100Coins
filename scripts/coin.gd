extends Area2D

@onready var game_manager: Node = %"Game Manager"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered() -> void:
	game_manager.AddPoint()
	animation_player.play("pickup")
