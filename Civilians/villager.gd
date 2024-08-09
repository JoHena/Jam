extends civ_movement

# On start pick a random direction to walk to

func _ready():
	random_direction()

#  When the timer runs out change your movement direction

func _on_timer_timeout():
	random_direction()