class_name Player
extends CharacterBody2D

@onready var sprite = $sprite
@onready var state_machine = $state_machine
@onready var move_state = $state_machine/move
@onready var anim = $AnimationPlayer
@onready var tree = $AnimationTree

# Animators
@onready var shadow_anim = $ShadowContainer/ShadowOverlay/shadow_anim
@onready var spook_drain_timer = $SpookDrain
@onready var spook_meter = $SpookMeter
@onready var sound = $SoundQueue

var CAN_MOVE: bool = false

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if CAN_MOVE:
		state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	if CAN_MOVE:
		state_machine.process_physics(delta)

func _process(delta: float) -> void:
	if CAN_MOVE:
		state_machine.process_frame(delta)

func die():
	tree.active = false
	sound.playEffect('die',1, 1.3)
	anim.play("death")
	await anim.animation_finished
	get_tree().reload_current_scene()

func _on_spook_meter_value_changed(value):
	if value <= 0:
		die()
