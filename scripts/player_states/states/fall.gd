extends BaseState

#@export  var move_speed = 60



func physics_process(_delta: float) -> BaseState:
	
	#if player.is_on_wall():
		#return slide_node
	if Input.is_action_just_pressed("Jump") and playerStats.DOUBLE_JUMPS > 0:
		playerStats.DOUBLE_JUMPS-=1	
		return jump_node
		
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
		playerStats.DOUBLE_JUMPS = 2 #Maybe there's a better way for doing this in jump logic
		if move != 0:
			if Input.is_action_pressed("Sprint"):
				return run_node
			return walk_node
		else:
			return idle_node
	return null
