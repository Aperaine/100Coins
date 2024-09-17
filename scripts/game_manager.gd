extends Node
@onready var cake_object: Area2D = %CakeObject
@onready var score_display: RichTextLabel = %ScoreDisplay
@onready var leaderboard_ui: LeaderboardUI = %LeaderboardUI
@onready var win_display: Panel = %"Win Display"
@onready var final_data: RichTextLabel = %"Final Data"
@onready var player_character: CharacterBody2D = %PlayerCharacter
@onready var cake_display: RichTextLabel = $ScoreDisplay

var score = 0
var deaths = 0
var time = 0
var supe = 1
var paused:bool = true

func AddPoint():
	score+=1
	score_display.updatetext(score)
	cake_display.parse_bbcode("[center]%s/100[img=10x10]res://100 Coins Icon.png[/img]" % [score])

func AddDeath():
	deaths+=1

func SetPause(state):
	paused = state
	
func _process(delta: float) -> void:
	if score == 100:
		cake_object.Unlocked()
		cake_display.hide()
	if !paused:
		time += delta * supe
	if Input.is_action_just_released("leaderboard_open"):
		leaderboard_ui.visible = !leaderboard_ui.visible

func Win():
	supe = 0
	Global.time = (snapped(time,0.01))
	player_character.GGs()
	win_display.visible = true
	final_data.text = ("[font_size=48][center] Deaths: %s\nTime: %s seconds" % [deaths, (snapped(time,0.01))])


func _on_open_leaderboard_2_button_up() -> void:
	if Global.submitted:
		get_tree().reload_current_scene()
	else:
		leaderboard_ui.show()


func _on_button_button_up() -> void:
	leaderboard_ui.hide()

func _ready() -> void:
	if Global.submitted:
		Global.submitted = false
		leaderboard_ui.show()
