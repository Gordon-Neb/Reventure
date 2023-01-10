extends BaseState

func enter() -> void:
	super.enter()
	player.velocity.x = 0
	
	if playerStats.ALLOW_WALL_JUMP: #Resets when idle or move state
		playerStats.WALL_TOUCHED = true
		playerStats.ALLOW_WALL_JUMP = false

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
	
	if Input.is_action_just_pressed("Jump"):
		#player.velocity.x = -move * playerStats.PUSH_DISTANCE
		#playerStats.JUMPS_LEFT = 1 #We need to wait for push distance before we can move in air again
		return walljump_node
		
	player.velocity.y = playerStats.WALL_GRAVITY
	player.move_and_slide()
	
	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("Sprint"):
				return run_node
			return walk_node
		else:
			return idle_node
			
	if not player.is_on_wall():
		playerStats.WALL_TOUCHED = false
		return fall_node
		
	return null


