extends Control


func _ready():
	MenuMusic.play_music_menu()
	
func _process(delta):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	


func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://UI elements/options.tscn")
