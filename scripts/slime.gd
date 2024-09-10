extends Node2D

const speed = 60

var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right_down: RayCast2D = $RayCastRightDown
@onready var ray_cast_left_down: RayCast2D = $RayCastLeftDown

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding() or not ray_cast_right_down.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding() or not ray_cast_left_down.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * speed * delta
