extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var jump_buffer:bool = false
var jump_availible:bool = false
var dead:bool = false
var justStarted:bool = true
var supe = 1
var hit_animation:bool = false
var health = 2

@onready var coyote_timer: Timer = $"Coyote Timer"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var deathsound: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var game_manager: Node = %"Game Manager"
@onready var hurt_tint: Panel = %HurtTint
@export var jump_buffer_timer: float = 0.1

func _ready():
	add_to_group("player&death")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		if !coyote_timer.is_stopped() && !dead:
			jump_availible = true
		else:
			jump_availible = false
	
	elif !dead:
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
	#sprite flip
	if direction > 0 && !dead:
		animated_sprite.flip_h = false
	elif direction < 0 && !dead:
		animated_sprite.flip_h = true
	
	if !(direction == 0)&&justStarted:
		justStarted = false
		game_manager.SetPause(false)
	
	#Animations
	if !dead:
		if is_on_floor() && !hit_animation:
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		elif !hit_animation:
			animated_sprite.play("jump")
		if direction:
			velocity.x = direction * SPEED * supe
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * supe)
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
func Jump() -> void:
	audio_stream_player_2d.play()
	velocity.y = JUMP_VELOCITY * supe
	coyote_timer.stop()
	jump_availible = false
func On_Jump_Buffer_Timeout() -> void:
	jump_buffer = false
func Death() -> void:
	dead=true
	animated_sprite.play("die")
	deathsound.play()
	game_manager.AddDeath()
	
func Alive() -> void:
	if dead:
		dead = false
		position=Vector2(0,0)
		hurt_tint.modulate.a = 0
		health = 2
	
func GGs() -> void:
	supe = 0

func Hurt() -> void:
	hurt_tint.modulate.a += 0.2
	if !dead:
		health -= 1
		if health == 0:
			Death()
		else:
			deathsound.play()
			hit_animation = true
			animated_sprite.play("hit")
			

func Untint() -> void:
	while hurt_tint.modulate.a > 0:
		hurt_tint.modulate.a -= 1

func _on_animated_sprite_2d_animation_finished() -> void:
	if hit_animation:
		hit_animation = false
