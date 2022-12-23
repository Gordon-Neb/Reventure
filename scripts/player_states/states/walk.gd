extends MoveState

func input(event: InputEvent) -> BaseState:
	# First run parent code and make sure we don't need to exit early
	# based checked its logic
	var new_state = super.input(event)
	if new_state:
		return new_state
		
	if Input.is_action_just_pressed("Sprint"):
		return run_node
	return null

func physics_process(_delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_node

	var move = get_movement_input()
#	if move < 0:
#		player.animations.flip_h = true
#	elif move > 0:
#	player.animations.flip_h = false
	
	player.velocity.y += player.gravity
	player.velocity.x = move * playerStats.WALK_SPEED
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	
	if move == 0:
		return idle_node

	return null
