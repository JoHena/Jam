extends ProgressBar

@export var SPOOK_DRAIN_AMOUNT: int = 10

func _on_spook_drain_timeout():
	value -= SPOOK_DRAIN_AMOUNT
