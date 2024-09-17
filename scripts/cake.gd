extends Area2D
@onready var locked_sprite_2d: Sprite2D = $LockedSprite2D
@onready var unlocked_sprite_2d: Sprite2D = $UnlockedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var game_manager: Node = %"Game Manager"


func Unlocked():
	locked_sprite_2d.visible = false
	unlocked_sprite_2d.visible = true
	collision_shape.disabled = false
	print("Unlocked")


func _on_body_entered(_body: Node2D) -> void:
	print("win")
	game_manager.Win()
