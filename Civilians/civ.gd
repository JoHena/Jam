extends CharacterBody2D
class_name civ_movement


# This code moves the civilians around randomly 
# an alternative could be having points where activities can be had by the villagers and have each civ pick one randomly 
# to move towards and do it for some time

var current_state

enum civ_state {
	move_left, 	# 0
	move_right, # 1
	move_down, 	# 2
	move_up 	# 3
} 

# Movement speed
@export var SPEED: float = 10

# Animation player
@onready var anim = $AnimationPlayer

# Timer to switch direction
@onready var timer = $Timer

# Simple move state handler

func _physics_process(_delta):
	match current_state:
		civ_state.move_left:
			velocity = Vector2.LEFT * SPEED
		civ_state.move_right:
			velocity = Vector2.RIGHT * SPEED
		civ_state.move_up:
			velocity = Vector2.UP * SPEED
		civ_state.move_down:
			velocity = Vector2.DOWN * SPEED
			
	move_and_slide()


# Gets a random direction between 0 and 3 for the direction of movement

func random_direction():
	current_state = randi() % 4 
	random_timer()

# Randomizes the timer for changing direction 

func random_timer():
	timer.wait_time = clamp(randi() % 3, 1, 3)