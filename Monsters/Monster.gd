extends CharacterBody2D

class_name Monster

@export var MAX_SPEED = 35			
@export var MIN_SPEED = 30	
@export var DAMAGE = 30	

var target = null
var IS_DEAD = false

@onready var navigation_agent_2d = $NavigationAgent2D
@onready var detection_area = $Detection
@onready var hitbox = $Hitbox

@onready var death_timer = $Death_timer

@onready var sound_queue = $SoundQueue
@onready var animation_player = $AnimationPlayer

var spawn_anim_finished

func _ready():
	animation_player.play("spawn")
	sound_queue.playEffect('summon', 1.32, 2.37)
	await animation_player.animation_finished
	animation_player.play("move")
	spawn_anim_finished = true
	death_timer.start()
	
func _physics_process(_delta):
	if spawn_anim_finished and !IS_DEAD:
		if target != null:
			follow_target()
		move_and_slide()

func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position

func follow_target():
	navigation_agent_2d.target_position = target.global_position
	
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * MAX_SPEED

func move(dir):
	velocity = dir * randi_range(MIN_SPEED, MAX_SPEED)

func _on_death_timer_timeout():
	IS_DEAD = true
	sound_queue.playEffect('summon', 3.32, 2.39)
	animation_player.play_backwards("spawn")
	await animation_player.animation_finished
	queue_free()

func _on_detection_body_entered(body):
	detection_area.set_deferred("monitoring", false)
	
	if body.is_in_group('Civilians'):
		target = body
		seeker_setup()
		
	var btplayer := get_node_or_null(^"BTPlayer") as BTPlayer
	if btplayer:
		btplayer.set_active(false)

func hurtCiv(bodys: Array):
	for body in bodys:
		if body.is_in_group('Civilians'):
			sound_queue.playEffect('attack', 1.32, 2.37)
			body.take_damage(DAMAGE)																										
			body.scareMyself()

func _on_hit_timer_timeout():
	hurtCiv(hitbox.get_overlapping_bodies())
	
