class_name Player
extends CharacterBody2D

@onready var sprite = $sprite
@onready var state_machine = $state_machine

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


func _on_start_timer_timeout():
	CAN_MOVE = true
