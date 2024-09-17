extends Node
@onready var cake_object: Area2D = %CakeObject
@onready var score_display: RichTextLabel = %ScoreDisplay
var score = 0

func AddPoint():
	score+=1
	score_display.updatetext(score)

func _process(_delta: float) -> void:
	if score == 100:
		cake_object.Unlocked()
