extends Control

signal game_started

@export var transition_duration = 2.00
@export var transition_type = 1 # TRANS_SINE
@export var sound_queue: SoundQueue

@onready var play_button = $VBoxContainer/Main_Container/Main/Play
@onready var anim = $AnimationPlayer

var game_has_started = false

func _ready():
	sound_queue.playMusic('menu_music')

func paused(is_paused: bool):
	get_tree().paused = is_paused
	
	if is_paused:
		anim.play("onLoad", -1, 2.5)
	else:
		hide()

func _on_play_pressed():
	
	if game_has_started: # if game already started treat as pause
		sound_queue.playMusic('button_click')
		get_tree().paused = false
		hide()
		return
		
	game_has_started = true
	sound_queue.playMusic('button_click')
	game_started.emit()
	hide()
	fade_out(sound_queue.SoundStreams['menu_music'])
	
func _on_exit_pressed():
	sound_queue.playMusic('button_click')
	get_tree().quit()

func _on_options_pressed():
	sound_queue.playMusic('button_click')
	anim.play("options_load")
	
func fade_out(stream_player):
	# tween music volume down to 0
	var tween = create_tween()
	tween.tween_property(stream_player, "volume_db", -80, transition_duration)
	tween.tween_callback(stream_player.stop)

func _on_credits_pressed():
	sound_queue.playMusic('button_click')
	anim.play("credits_load")
