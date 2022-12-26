extends BaseState

func enter() -> void:
	super.enter()
	player.velocity.x = 0
	playerStats.CAN_JUMP = false
	playerStats.JUMP_COUNT = 2 #Maybe there's a better way for doing this in jump logic

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
	player.velocity.y += playerStats.GRAVITY
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	return null
