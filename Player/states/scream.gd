extends State
													
func process_frame(_delta: float) -> State:						
	animation_tree.set('parametrs/conditions/is_screaming', true)
	return null