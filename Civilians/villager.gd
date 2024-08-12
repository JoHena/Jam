extends civ_movement

@export var SCARES_TILL_DEATH: float = 3
@export var SCARED_AMOUNT: float = 20
@export var SCARED_SPEED = 30			
@export var is_scared: bool = false

var TIMES_SCARED: float = 0
var POINTS_SCENE = preload("res://Civilians/scare_score.tscn")

# On start pick a random direction to walk to
func _ready():
	var random_skin = randi() % 3 
	if random_skin == 2: # This is a temp fix sice civs and guards are mixed in the sprite sheet
		sprite.frame = 4
		return
	sprite.frame = random_skin
	random_direction()
					
func _physics_process(_delta):
	super(_delta)
	checkScaredState()


#  When the timer runs out change your movement direction
func _on_timer_timeout():
	random_direction()

# Check if the entity is scared
func checkScaredState():
	if TIMES_SCARED >= SCARES_TILL_DEATH:
		anim.play('death')
		current_state = 4 # move_none - Stops moving
		return
		
	if is_scared: 
		anim.play('scared')
		anim.speed_scale = TIMES_SCARED + 1
		SPEED = SCARED_SPEED * TIMES_SCARED
	else:
		anim.play('walk')
		SPEED = 10 

# When scared show the points gained	
func showScarePoints():
	var instance = POINTS_SCENE.instantiate()
	instance.text = "+" + str(SCARED_AMOUNT)
	add_child(instance)

func handleScare():
	showScarePoints()
	sound_queue.playEffect('scream', 1, 1.83)

# When scream finishes delete itself
func _on_scream_finished():
	if TIMES_SCARED >= SCARES_TILL_DEATH:
		queue_free()
