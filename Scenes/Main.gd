extends Node2D

@onready var main_menu = $CanvasLayer/MainMenu
@onready var game_start_timer = $PhantomCamera2D/Start_Timer
@onready var player = $Pausable/Player
@onready var camera_anim = $PhantomCamera2D/AnimationPlayer

@export var behavior_tree_view: BehaviorTreeView
@export var bt_player_parent: Node

var bt_player: BTPlayer
var paused: bool = false
var game_started: bool = false

func _ready():									
	main_menu.game_started.connect(start_game)
	bt_player = bt_player_parent.find_child('BTPlayer')
	pass # Replace with function body.	

func _process(_delta):
	# For testing behaviour tree	
	if is_instance_valid(bt_player):
		var inst: BTTask = bt_player.get_tree_instance()
		var bt_data: BehaviorTreeData = BehaviorTreeData.create_from_tree_instance(inst)
		behavior_tree_view.update_tree(bt_data)

	if game_started:
		checkPause()

func start_game():
	game_start_timer.start()
	camera_anim.play("play_start")
	player.shadow_anim.play("shadow_exit")

func _on_start_timer_timeout():
	game_started = true
	player.CAN_MOVE = true
	
func checkPause():
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		main_menu.paused(paused)
			
		
