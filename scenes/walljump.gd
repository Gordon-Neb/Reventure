extends BaseState

func enter() -> void:
	super.enter()
	player.velocity.y = playerStats.JUMP_FORCE
	var move = 0
	if Input.is_action_pressed("Left"):
		move = -1
		#player.animations.flip_h = true
	elif Input.is_action_pressed("Right"):
		move = 1
		
	player.velocity.x = -move * playerStats.PUSH_DISTANCE
func input(_event: InputEvent) -> BaseState:
	
	return null
func physics_process(_delta: float) -> BaseState:
	
	player.velocity.y += playerStats.FALL_GRAVITY
	
	player.move_and_slide()
	if player.velocity.y > -40:
		return fall_node
		
	if player.is_on_floor():
		return idle_node
	return null
