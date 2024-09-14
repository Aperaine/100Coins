extends Area2D
var character

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	add_to_group("player&death")

func _on_body_entered(body: Node2D) -> void:
	print("ded")
	timer.start()
	character = body
	get_tree().call_group("player&death", "Death")
	audio_stream_player_2d.play()

func _on_timer_timeout() -> void:
	character.position=Vector2(0,0)
	get_tree().call_group("player&death", "Alive")
