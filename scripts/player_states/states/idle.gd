extends BaseState

func enter() -> void:
	super.enter()
	playerStats.JUMPS_LEFT = playerStats.MAX_JUMP_COUNT # Reset Jumps
	#playerStats.ALLOW_MIDAIR_JUMP = false
	playerStats.ALLOW_WALL_JUMP = true

func input(_event: InputEvent) -> BaseState:

	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		if Input.is_action_pressed("Sprint"):
			return run_node
		return walk_node
	elif Input.is_action_just_pressed("Jump"):
		return jump_node
	elif Input.is_action_just_pressed("Dash"):
		return dash_node
	return null

func physics_process(_delta: float) -> BaseState:
	player.velocity.x = 0
	player.velocity.y += playerStats.GRAVITY
	player.move_and_slide()
	return null
