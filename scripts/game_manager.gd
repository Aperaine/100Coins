extends Node
@onready var cake_object: Area2D = %CakeObject
@onready var score_display: RichTextLabel = %ScoreDisplay
var score = 0
var deaths = 0
var time = 0
var paused:bool = true

func AddPoint():
	score+=1
	score_display.updatetext(score)

func AddDeath():
	deaths+=1

func SetPause(state):
	paused = state
	
func _process(delta: float) -> void:
	if score == 100:
		cake_object.Unlocked()
	if !paused:
		time += delta

func Win():
	pass
