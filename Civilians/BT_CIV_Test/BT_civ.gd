extends CharacterBody2D

# Scare Props
@export var SCARED_AMOUNT: float = 20

# Props
@export var MAX_SCARED_SPEED = 55			
@export var MIN_SCARED_SPEED = 35			

@export var MAX_SPEED = 30			
@export var MIN_SPEED = 10			

@export var IS_SCARED: bool = false

@export var sound_queue: SoundQueue
@onready var anim = $AnimationPlayer
@onready var sprite = $sprite
@onready var health = $Health

var IS_DEAD: bool = false
var POINTS_SCENE = preload("res://Civilians/scare_score.tscn")

func _ready():
	sprite.frame = randi_range(0,4)

func _physics_process(_delta):
	move_and_slide()

func check_for_self(node):
	return node == self

func move(dir):
	if IS_SCARED:
		velocity = dir * randi_range(MIN_SCARED_SPEED, MAX_SCARED_SPEED)
	else:
		velocity = dir * randi_range(MIN_SPEED, MAX_SPEED)
	
	if IS_SCARED:
		anim.play("scared")
		return
		
	anim.play('walk')

func scareMyself():
	if !IS_SCARED:
		Global.score += SCARED_AMOUNT
		sprite.frame += 6
	IS_SCARED = true	

# When scared show the points gained	
func showScarePoints():
	var instance = POINTS_SCENE.instantiate()
	instance.text = "+" + str(SCARED_AMOUNT)
	add_child(instance)

func die():
	IS_DEAD = true
	velocity = Vector2.ZERO
	anim.play('death')
	await anim.animation_finished
	Global.score += 100
	queue_free()

func handleScare():
	showScarePoints()
	sound_queue.playEffect('scream', 1, 1.83)
	var btplayer := get_node_or_null(^"BTPlayer") as BTPlayer
	if btplayer and not IS_DEAD:
		btplayer.restart()

func talk():
	var btplayer := get_node_or_null(^"BTPlayer") as BTPlayer

	if btplayer:
		btplayer.set_active(false)
		
	move(Vector2.ZERO)
	
	if(IS_SCARED):
		anim.play('alert_person')
	else:
		anim.play("chatting")
		
	await anim.animation_finished
		
	if btplayer and not IS_DEAD:
		btplayer.restart()
		

func take_damage(amount: float):
	var btplayer := get_node_or_null(^"BTPlayer") as BTPlayer
	
	if btplayer:
		btplayer.set_active(false)

	health.take_damage(amount)
	
	if health.health <= 0:
		die()
		return
	
	Global.score += 50
	
	anim.play('damaged')
	await anim.animation_finished
	
	if btplayer and not IS_DEAD:
		btplayer.restart()


func _on_area_2d_body_entered(_body):
	velocity = -velocity

func _on_visible_on_screen_notifier_2d_screen_entered():
	var btplayer := get_node_or_null(^"BTPlayer") as BTPlayer
	if btplayer and not IS_DEAD:
		btplayer.restart()

func _on_visible_on_screen_notifier_2d_screen_exited():
	var btplayer := get_node_or_null(^"BTPlayer") as BTPlayer
	if btplayer and not IS_DEAD:
		btplayer.set_active(false)
