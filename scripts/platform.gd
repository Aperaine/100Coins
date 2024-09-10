extends AnimatableBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
var style = 0
var mini = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	style = get_meta("style")
	mini = get_meta("mini")
	if mini:
		collision_shape_2d.scale.x = 0.5
		print("smol")
		sprite_2d.region_rect = Rect2 (0, 16*style, 16, 9)
	else:
		sprite_2d.region_rect = Rect2 (16, 16*style, 32, 9)
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
