extends BTAction

@export var dir_var: StringName = &"dir"

func _tick(_delta: float) -> Status:
	random_dir()
	return SUCCESS

func random_dir():
	var dir = Vector2(randi_range(-2, 1), randi_range(-2, 1))
 
	if dir.x < 0:
		dir.x = -1
	else: 
		dir.x = 1
	
	if dir.y < 0:
		dir.y = -1
	else:
		dir.y = -1

	blackboard.set_var(dir_var, dir)
	
	return dir
