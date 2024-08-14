extends State

# Exports
@export var SPEED: float = 100
@export var ACCELERATION: float = 10
@export var SHADOW_SPOOK_DRAIN_AMOUNT: float = 30	
@export var SHADOW_TIMER: Timer

# Logic
var IS_SHADOW: bool = false

# onready
@onready var screamArea = $"../../Area2D"
@onready var scaremeter = $"../../SpookMeter"
@onready var shadow_anim = $"../../ShadowContainer/ShadowOverlay/shadow_anim"

func process_physics(_delta: float) -> State:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	parent.velocity.x = move_toward(parent.velocity.x, SPEED * direction.x, ACCELERATION)
	parent.velocity.y = move_toward(parent.velocity.y, SPEED * direction.y, ACCELERATION)

	parent.move_and_slide()

	if direction.x != 0:
		parent.sprite.flip_h = direction.x < 0

	animation_tree['parameters/Move/blend_position'] = direction

	return null
	
func process_input(_delta):
	scream()
	shadow_step()

# We do this here instead of another state to still move while screaming
func scream():
	if Input.is_action_just_pressed('attack'):
		sound_queue.playEffect('scare', 1.32, 2.37)
		animation_tree['parameters/conditions/is_screaming'] = true
		scareCivs(screamArea.get_overlapping_bodies())
	else: 
		animation_tree['parameters/conditions/is_screaming'] = false

func shadow_step():
	if IS_SHADOW:
		if Input.is_action_just_pressed('shadow_step'):
			sound_queue.playEffect('dimention_shift', 1.32, 1.72)
			switch_colission_layers()
			
		if scaremeter.value <= 0:
			sound_queue.playEffect('dimention_shift', 1.32, 1.72)
			switch_colission_layers()
			
	elif Input.is_action_just_pressed('shadow_step'):
		if (scaremeter.value - SHADOW_SPOOK_DRAIN_AMOUNT) >= 0:
			sound_queue.playEffect('dimention_shift', 1.32, 1.72)
			switch_colission_layers()

func switch_colission_layers():
	if IS_SHADOW:
		# If is shadow return to normal 
		SHADOW_TIMER.stop()
		IS_SHADOW = false
		shadow_anim.play("shadow_exit")
		# Set interactable masks
		parent.set_collision_mask_value(1, true) # Can now collide with 
		screamArea.set_collision_mask_value(3, true)
	else: 
		SHADOW_TIMER.start()
		# If not shadow enter shadows 
		IS_SHADOW = true
		shadow_anim.play("shadow_enter")
		# Set mask interactions
		parent.set_collision_mask_value(1, false) # Can't interact with walls
		screamArea.set_collision_mask_value(3, false) # Can't interact with NPC's

# check if body is scareable
func scareCivs(bodys: Array):
	for body in bodys:
		if body.is_in_group('Civilians'):
			body.handleScare()																										
			handleScareMeter(body.SCARED_AMOUNT)
			body.scareMyself()
								
# change scare meter amount - Animates quicker on full meter
func handleScareMeter(scare_amount: float):
	scaremeter.value += scare_amount
	if scaremeter.value == 100:
		scaremeter.get_child(0).play('spook_full')
	else:
		scaremeter.get_child(0).play('spook')	

func _on_shadow_timer_timeout():
	scaremeter.value -= SHADOW_SPOOK_DRAIN_AMOUNT
