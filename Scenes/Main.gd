extends Node2D

@onready var main_menu = $CanvasLayer/MainMenu
@onready var game_start_timer = $PhantomCamera2D/Start_Timer
@onready var player = $Player
@onready var camera_anim = $PhantomCamera2D/AnimationPlayer
#PauseMenu
@onready var pause_menu = $"CanvasLayer/Pause Menu"


func _ready():
	main_menu.game_started.connect(start_game)
	pass # Replace with function body.


func _process(delta):
	var _x = delta
	if Input.is_action_just_pressed("pause"):
		#pause(get_tree().paused)
		pause()
	pass

func start_game():
	game_start_timer.start()
	camera_anim.play("play_start")
	player.shadow_anim.play("shadow_exit")

func _on_start_timer_timeout():
	player.CAN_MOVE = true
	
#func pause(state):
	#if state:
		#pause_menu.hide()
		#get_tree().paused = false
	#else:
		#get_tree().paused = true
		#pause_menu.show()
		
func pause():
	if not Input.is_action_just_pressed("pause"):
		return # do nothing if escape isn't pressed
	elif pause_menu.visible: # we are paused
		pause_menu.visible = false
		get_tree().paused = false 
	else: # we are unpaused
		pause_menu.visible = true
		get_tree().paused = true
