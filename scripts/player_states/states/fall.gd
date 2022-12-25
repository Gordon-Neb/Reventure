extends BaseState

#@export  var move_speed = 60



func physics_process(_delta: float) -> BaseState:
	
	#if player.is_on_wall():
		#return slide_node
	if Input.is_action_just_pressed("Jump") and playerStats.JUMP_COUNT > 0:
		playerStats.JUMP_COUNT-=1	
		return jump_node
	
	elif Input.is_action_just_pressed("Jump"):
		playerStats.BUFFERED_JUMP = true
		player.jumpBufferTimer.start()	
	var move = 0
	if Input.is_action_pressed("Left"):
		move = -1
		#player.animations.flip_h = true
	elif Input.is_action_pressed("Right"):
		move = 1
		#player.animations.flip_h = false
	if Input.is_action_pressed("Sprint"): 
		player.velocity.x = move * playerStats.RUN_SPEED
	else: 
		player.velocity.x = move * playerStats.WALK_SPEED
		
	player.velocity.y += (playerStats.GRAVITY + playerStats.FALL_GRAVITY) #fall gravity can be adjusted later
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity

	if player.is_on_floor():
		playerStats.JUMP_COUNT = 2 #Maybe there's a better way for doing this in jump logic
		if playerStats.BUFFERED_JUMP:
			playerStats.JUMP_COUNT -= 1
			return jump_node
			
		
		
		if move != 0:
			if Input.is_action_pressed("Sprint"):
				return run_node
			return walk_node
		else:
			return idle_node
	return null
