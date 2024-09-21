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
		damage = 2
		timer.start()
		get_tree().call_group("player&death", "Death")
	else:
		if damage == 1:
			print("ded")
			damage = 2
			timer.start()
			get_tree().call_group("player&death", "Death")
		elif damage == 0:
			damage = 1
			print("hurt")
			get_tree().call_group("player&death", "Hurt")
			tint_timer.start()
	

func _on_timer_timeout() -> void:
	get_tree().call_group("player&death", "Alive")
	damage = 0

func _on_tint_timer_timeout() -> void:
	get_tree().call_group("player&death", "Untint")
