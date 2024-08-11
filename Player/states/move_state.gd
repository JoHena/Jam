extends State

const SPEED: float = 100
const ACCELERATION: float = 10
var IS_SHADOW: bool = false

@onready var screamArea = $"../../Area2D"
@onready var scaremeter = $"../../scaremeter"

func process_physics(_delta: float) -> State:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	parent.velocity.x = move_toward(parent.velocity.x, SPEED * direction.x, ACCELERATION)
	parent.velocity.y = move_toward(parent.velocity.y, SPEED * direction.y, ACCELERATION)

	parent.move_and_slide()

	if direction.x != 0:
		parent.sprite.flip_h = direction.x < 0

	return null

func process_input(_event: InputEvent) -> State:
	scream()
	return null	


# We do this here instead of another state to still move while screaming
func scream():
	if Input.is_action_just_pressed('attack'):
		animation_tree['parameters/conditions/is_screaming'] = true
		scareCivs(screamArea.get_overlapping_bodies())
	else: 
		animation_tree['parameters/conditions/is_screaming'] = false

	if Input.is_action_just_pressed('shadow_step'):
		if IS_SHADOW:
			IS_SHADOW = false
			$"../../ShadowContainer/ShadowOverlay/shadow_anim".play("shadow_exit")
		else: 
			IS_SHADOW = true
			$"../../ShadowContainer/ShadowOverlay/shadow_anim".play("shadow_enter")

# check if body is scareable
func scareCivs(bodys: Array):
	for body in bodys:
		if body.is_in_group('Civilians'):
			if !body.is_scared:
				handleScareMeter(body.SCARED_AMOUNT)
			body.is_scared = true

# change scare meter amount - Animates quicker on full meter
func handleScareMeter(scare_amount: float):
	scaremeter.value += scare_amount
	if scaremeter.value == 100:
		scaremeter.get_child(0).play('spook_full')
	else:
		scaremeter.get_child(0).play('spook')
