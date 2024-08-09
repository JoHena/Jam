extends State

@export var speed: float = 100
@export var acceleration: float = 10


func process_physics(_delta: float) -> State:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	parent.velocity.x = move_toward(parent.velocity.x, speed * direction.x, acceleration)
	parent.velocity.y = move_toward(parent.velocity.y, speed * direction.y, acceleration)

	parent.move_and_slide()
	
	if direction.x != 0:
		parent.sprite.flip_h = direction.x < 0

	return null
