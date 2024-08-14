extends BTAction

@export var dir_var := &"dir"

func _tick(_delta: float) -> Status:
	var dir = blackboard.get_var(dir_var)
	
	
	if agent.IS_SCARED:
		agent.move(dir, randi_range(agent.MIN_SCARED_SPEED, agent.MAX_SCARED_SPEED))
	else:
		agent.move(dir, randi_range(agent.MIN_SPEED, agent.MAX_SPEED))
	
	return SUCCESS
