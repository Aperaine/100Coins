extends Area2D
var character

@onready var timer: Timer = $Timer

func _ready():
	add_to_group("player&death")

func _on_body_entered(_body: Node2D) -> void:
	print("ded")
	timer.start()
	get_tree().call_group("player&death", "Death")

func _on_timer_timeout() -> void:
	get_tree().call_group("player&death", "Alive")
