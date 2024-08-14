extends ProgressBar

@export var HEALTH: float = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(dmg: float):
	HEALTH -= dmg
