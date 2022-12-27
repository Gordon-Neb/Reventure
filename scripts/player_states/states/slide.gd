extends BaseState

func enter() -> void:
	super.enter()
	player.velocity.x = 0

func input(_event: InputEvent) -> BaseState:
	
	
	return null

func physics_process(_delta: float) -> BaseState:
	
	var move = 0
	if Input.is_action_pressed("Left"):
		move = -1
		#player.animations.flip_h = true
	elif Input.is_action_pressed("Right"):
		move = 1
		
	player.velocity.x = move * playerStats.WALK_SPEED
	
	if Input.is_action_just_pressed("Jump") and move != 0:
		playerStats.WALL_JUMP = true
		player.wallTouchedTimer.start()
		return jump_node
		
	player.velocity.y = playerStats.WALL_GRAVITY
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	
	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("Sprint"):
				return run_node
			return walk_node
		else:
			return idle_node
			
	if not player.is_on_wall():
		return fall_node
	return null


