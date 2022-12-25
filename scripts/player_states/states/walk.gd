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

	
	
	player.velocity.y += playerStats.GRAVITY
	player.velocity.x = move * playerStats.WALK_SPEED
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	
	var was_on_floor = player.is_on_floor()
	player.move_and_slide()
	var just_left_ground = player.is_on_floor() and was_on_floor
	player.velocity = player.velocity
	
	if just_left_ground and player.velocity.y >= 0:
		playerStats.COYOTE_JUMP = true
		player.coyoteJumpTimer.start()
	
	if move == 0:
		return idle_node

	return null
