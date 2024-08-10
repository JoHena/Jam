extends Control

func _process(delta):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
