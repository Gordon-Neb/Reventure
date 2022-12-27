extends BaseState

func enter() -> void:
	super.enter()

	playerStats.CAN_JUMP = false

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
	player.velocity.x = move_toward(player.velocity.x, 0, playerStats.FRICTION)
	player.velocity.y += playerStats.GRAVITY
	player.move_and_slide()
	return null
