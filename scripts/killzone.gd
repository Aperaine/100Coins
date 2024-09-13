extends Area2D
var character
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("ded")
	timer.start()
	character = body


func _on_timer_timeout() -> void:
	character.position=Vector2(0,0)
