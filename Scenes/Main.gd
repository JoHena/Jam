extends Node2D

@onready var main_menu = $CanvasLayer/MainMenu
@onready var game_start_timer = $PhantomCamera2D/Start_Timer
@onready var player = $Player
@onready var camera_anim = $PhantomCamera2D/AnimationPlayer

func _ready():
	main_menu.game_started.connect(start_game)
	pass # Replace with function body.


func _process(delta):
	var _x = delta
	pass

func start_game():
	game_start_timer.start()
	camera_anim.play("play_start")
	player.shadow_anim.play("shadow_exit")

func _on_start_timer_timeout():
	player.CAN_MOVE = true
