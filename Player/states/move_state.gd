extends State

const SPEED: float = 100
const ACCELERATION: float = 10

@onready var animation_tree = $"../../AnimationTree"

func process_physics(_delta: float) -> State:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	parent.velocity.x = move_toward(parent.velocity.x, SPEED * direction.x, ACCELERATION)
	parent.velocity.y = move_toward(parent.velocity.y, SPEED * direction.y, ACCELERATION)

	parent.move_and_slide()

	if direction.x != 0:
		parent.sprite.flip_h = direction.x < 0

	animation_tree.set('parameters/Move/blend_position', direction)

	return null
