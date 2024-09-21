extends Area2D
var character
var damage = 0

@onready var timer: Timer = $Timer
@onready var tint_timer: Timer = $TintTimer
@export var oneshot:bool = false

func _ready():
	add_to_group("player&death")

func _on_body_entered(_body: Node2D) -> void:
	if oneshot:
		print("ded")
		timer.start()
		get_tree().call_group("player&death", "Death")
	else:
		print("hurt")
		get_tree().call_group("player&death", "Hurt")
		tint_timer.start()
		if timer.is_stopped():
			timer.start()

func _on_timer_timeout() -> void:
	get_tree().call_group("player&death", "Alive")

func _on_tint_timer_timeout() -> void:
	get_tree().call_group("player&death", "Untint")
