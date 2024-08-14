extends BTAction

@export var dir_var := &"dir"

func _tick(_delta: float) -> Status:
	var dir = blackboard.get_var(dir_var)
	agent.move(dir)
	return SUCCESS
