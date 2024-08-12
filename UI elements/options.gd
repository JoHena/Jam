extends Control

@export var anim: AnimationPlayer

func _on_back_pressed():
	anim.play("menu_load")
