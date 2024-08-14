extends BTAction

func _tick(_delta: float) -> Status:
	agent.move(Vector2.ZERO, 0)
	return SUCCESS
	
	
