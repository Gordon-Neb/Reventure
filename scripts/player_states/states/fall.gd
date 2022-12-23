extends BaseState

@export  var move_speed = 60



func physics_process(_delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("Left"):
		move = -1
		#player.animations.flip_h = true
	elif Input.is_action_pressed("Right"):
		move = 1
		#player.animations.flip_h = false
	
	player.velocity.x = move * move_speed
	player.velocity.y += (player.gravity + 5) #fall gravity can be adjusted later
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
	return null
