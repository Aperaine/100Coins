extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var jump_buffer:bool = false
var jump_availible:bool = false
@onready var coyote_timer: Timer = $"Coyote Timer"
@export var jump_buffer_timer: float = 0.1



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if !coyote_timer.is_stopped():
			jump_availible = true
		else:
			jump_availible = false
	
	else:
		jump_availible = true
		coyote_timer.stop()
		if jump_buffer:
			Jump()
			jump_buffer=false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if jump_availible:
			Jump()
		else:
			jump_buffer = true
			get_tree().create_timer(jump_buffer_timer).timeout.connect(On_Jump_Buffer_Timeout)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
func Jump() -> void:
	velocity.y = JUMP_VELOCITY
	coyote_timer.stop()
	jump_availible = false
func On_Jump_Buffer_Timeout() -> void:
	jump_buffer = false
