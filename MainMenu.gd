extends Control

signal game_started

@export var transition_duration = 2.00
@export var transition_type = 1 # TRANS_SINE

func _ready():
	MenuMusic.play_music_menu()
	
func _process(delta):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_play_pressed():
	game_started.emit()
	hide()
	fade_out(MenuMusic)
	


func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://UI elements/options.tscn")
	
func fade_out(stream_player):
	# tween music volume down to 0
	var tween = create_tween()
	tween.tween_property(stream_player, "volume_db", -80, transition_duration)
	tween.tween_callback(stream_player.stop)
