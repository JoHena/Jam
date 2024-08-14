extends Control

@export var anim: AnimationPlayer
@export var sound_queue: SoundQueue

func _on_back_pressed():
	sound_queue.playMusic('button_click')
	anim.play("menu_load")
