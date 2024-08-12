extends Control

signal game_started

@export var transition_duration = 2.00
@export var transition_type = 1 # TRANS_SINE
@export var sound_queue: SoundQueue

@onready var anim = $AnimationPlayer

func _ready():
	sound_queue.playMusic('menu_music')
	
func _process(_delta):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_play_pressed():
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
