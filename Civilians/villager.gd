extends civ_movement

@export var SCARED_AMOUNT: float = 20
@export var SCARED_SPEED = 30					
@export var is_scared: bool = false :
	set(value):
		if !is_scared:
			showScarePoints()
		is_scared = value

@onready var scare_label = $scare_score
@onready var scare_anim = $scare_score/scare_score_anim

# On start pick a random direction to walk to
func _ready():
	random_direction()

func _physics_process(_delta):
	super(_delta)
	checkScaredState()


#  When the timer runs out change your movement direction
func _on_timer_timeout():
	random_direction()

# Check if the entity is scared
func checkScaredState():
	if is_scared: 
		anim.play('scared')
		SPEED = SCARED_SPEED
	else:
		anim.play('walk')
		SPEED = 10

# When scared show the points gained
func showScarePoints():
	scare_label.text = "+" + str(SCARED_AMOUNT)
	scare_anim.play('scared_score')