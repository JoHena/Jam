extends ProgressBar

@export var MAX_HEALTH: float = 100
var health: float = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if health < MAX_HEALTH:
		show()

func take_damage(dmg: float):
	health -= dmg
	value = health
