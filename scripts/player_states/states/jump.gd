extends BaseState

func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter()
	player.anim.play("Walk_Right")
	if playerStats.JUMPS_LEFT > 0:
		player.velocity.y = playerStats.JUMP_FORCE
		playerStats.JUMPS_LEFT -=1
			
func physics_process(_delta: float) -> BaseState:
	playerStats.CAN_JUMP = true
	player.velocity.y += playerStats.GRAVITY
	
	var move = 0
	if Input.is_action_pressed("Left"):
		move = -1
		player.sprite.flip_h = true
	elif Input.is_action_pressed("Right"):
		move = 1
		player.sprite.flip_h = false

	if Input.is_action_pressed("Sprint"):	
		player.velocity.x = move * playerStats.RUN_SPEED
	else: 
		player.velocity.x = move * playerStats.WALK_SPEED	
			
	player.move_and_slide()

	if player.velocity.y > 0:
		return fall_node
	if player.is_on_floor():
		return idle_node
		
	if Input.is_action_just_released("Jump") and player.velocity.y < playerStats.JUMP_RELEASE_FORCE:
		player.velocity.y = playerStats.JUMP_RELEASE_FORCE
		
#	elif Input.is_action_just_pressed("Jump"):
#		playerStats.BUFFERED_JUMP = true
#		player.jumpBufferTimer.start()	
	return null
