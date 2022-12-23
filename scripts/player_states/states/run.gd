extends MoveState


func input(event: InputEvent) -> BaseState:
	move_speed = 200
	# First run parent code and make sure we don't need to exit early
	# based checked its logic
	var new_state = super.input(event)
	if new_state:
		return new_state
	
	if Input.is_action_just_released("Sprint"):
		return walk_node

	return null
