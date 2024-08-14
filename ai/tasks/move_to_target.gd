extends BTAction

@export var target_Var := &"target"

@export var tolerance = Vector2(8, 8)				

func _tick(_delta: float) -> Status:
	
	var target: CharacterBody2D = null
	
	if is_instance_valid(blackboard.get_var(target_Var)):
		target = blackboard.get_var(target_Var)
	
	if target == null:
		return FAILURE
		
	var target_pos = target.global_position
	var dir = agent.global_position.direction_to(target_pos)
	
	if abs(agent.global_position - target_pos) < tolerance:
		agent.move(Vector2.ZERO)
		
		target.talk()
		
		if agent.IS_SCARED:
			target.IS_SCARED = true
			
		if target.IS_SCARED:
			agent.IS_SCARED = true
				
		return SUCCESS
	
	agent.move(dir)
	
	return RUNNING
	
	
