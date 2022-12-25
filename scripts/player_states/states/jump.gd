extends BaseState

func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter()
	player.velocity.y = playerStats.JUMP_FORCE
	

func physics_process(_delta: float) -> BaseState:
	#print(playerStats.DOUBLE_JUMPS)
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
		
	if Input.is_action_just_released("Jump") and player.velocity.y < playerStats.JUMP_RELEASE_FORCE:
		player.velocity.y = playerStats.JUMP_RELEASE_FORCE
		
	if Input.is_action_just_pressed("Jump") and playerStats.DOUBLE_JUMPS > 0:
		playerStats.DOUBLE_JUMPS -=1	
		print("Jumpi dumpi")
		player.velocity.y = playerStats.JUMP_FORCE
			
		
	player.velocity.y += playerStats.GRAVITY
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	#print(player.velocity.y)
	if player.velocity.y > 0:
		return fall_node

#	if player.is_on_floor():
#		jumpsLeft = 
#		print(jumpsLeft)
#		if move != 0:
#			if Input.is_action_pressed("Sprint"):
#				return run_node
#			return walk_node
#		return idle_node
	return null
