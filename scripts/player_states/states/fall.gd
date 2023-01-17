extends BaseState

func physics_process(_delta: float) -> BaseState:
	
	if player.is_on_wall():
		return slide_node
		
	if Input.is_action_just_pressed("Jump") and playerStats.COYOTE_JUMP:
		playerStats.COYOTE_JUMP = false	
		return jump_node
		
	elif Input.is_action_just_pressed("Jump") and playerStats.JUMPS_LEFT > 0:
		return jump_node
	elif Input.is_action_just_pressed("Jump"): #Player runs out of double jumps and tries to jump right before on ground level
		playerStats.BUFFERED_JUMP = true

		player.jumpBufferTimer.start()	
	var move = 0
	if Input.is_action_pressed("Left"):
		move = -1
		player.sprite.flip_h = true

	elif Input.is_action_pressed("Right"):
		move = 1
		player.sprite.flip_h = false

	player.velocity.x = move * playerStats.FALL_SPEED

		
	player.velocity.y += playerStats.FALL_GRAVITY #fall gravity can be adjusted later
	player.move_and_slide()

	if player.is_on_floor():
		playerStats.CAN_JUMP = false
		playerStats.JUMPS_LEFT = playerStats.MAX_JUMP_COUNT
		if playerStats.BUFFERED_JUMP:
			return jump_node
			
		if move != 0:
			if Input.is_action_pressed("Sprint"):
				return run_node
			return walk_node
		else:
			return idle_node
	return null
