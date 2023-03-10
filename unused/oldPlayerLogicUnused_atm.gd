

#@onready var coyoteJumpTimer := $CoyoteJumpTimer
#var coyote_jump = false
#
#@onready var jumpBufferTimer := $JumpBufferTimer
#var buffer_jump = false
#
#@onready var wallTouchedTimer := $WallTouchedTimer
#var wall_jump = false
#
#@onready var wallSlideTimer := $WallSlideTimer
#var wall_slide = false
#
#
#func _physics_process(delta):
#
#	var input = Vector2.ZERO
#	input.x = Input.get_axis("Left", "Right")
#	input.y = Input.get_axis("Jump", "Slide")
#
#	match state:
#		MOVE: move_state(input)
#		CLIMB:climb_state(input)
#		WALL: wall_state(input)
#		JUMP: jump_state(input)
#
#	#if state == 3: print("test")
#	#if state == 0: print("hello")
#	apply_gravity(GRAVITY) #Gravity should be applied the whole time
#
#func move_state(input):
#	DOUBLE_JUMPS = 1 #if character is in move state aka. touches ground he will get his double jump back
#
#	if is_on_wall():
#		state = WALL
#	elif can_jump(): state = JUMP
#
#	if not horizontal_move(input):
#		apply_friction()
#
#	if horizontal_move(input):
#		apply_acceleration(input.x)
#
#	move_and_slide() #Do Movement and get next State
#
#func wall_state(input):
#	velocity.y = WALL_GRAVITY
#	if is_on_floor():
#		state = MOVE
#	move_and_slide()
#
#func jump_state(input):
#
#
#	input_jump(input)
#	input_jump_release()
#	#if is_on_floor(): state = MOVE
#	#input_double_jump()
#	#buffered_jump()
#	#fast_fall()
#	#input_wall_jump(input)
#
#	#var was_on_floor = is_on_floor() #Remember Floor State
#	move_and_slide() #Do Movement and get next State
#	#var just_left_ground = not is_on_floor() and was_on_floor
##func do_coyote_jump(just_left_ground):
#	if just_left_ground and velocity.y >= 0:
#		coyote_jump = true
#		coyoteJumpTimer.start()
#func climb_state(input): #to be added
#	pass
#
#func can_jump():
#	return (is_on_floor() or coyote_jump) and Input.is_action_just_pressed("Jump")
#
#func input_jump(input):
#	#if state == JUMP or buffer_jump:
#		velocity.y = JUMP_FORCE
#		buffer_jump = false
#
#func input_jump_release():
#	if Input.is_action_just_released("Jump") and velocity.y < JUMP_RELEASE_FORCE:
#		velocity.y = JUMP_RELEASE_FORCE


#func input_double_jump():
#	if Input.is_action_just_pressed("Jump") and DOUBLE_JUMPS > 0:
#		velocity.y = JUMP_FORCE
#		DOUBLE_JUMPS-=1
#

#
#func input_wall_jump(input):
#	if is_on_wall() and Input.is_action_just_pressed("Jump") and input.x != 0:
#		wall_slide = true
#		wallSlideTimer.start()
#		velocity.y = JUMP_FORCE
#		wall_jump=true
#		velocity.x = -input.x * PUSH_DISTANCE
#		wallTouchedTimer.start()
#
#func horizontal_move(input):
#	return input.x != 0
#
#func apply_gravity(amount):
#		# Add the gravity.
#		#if not is_on_wall(): 
#		velocity.y += amount
#		#else: velocity.y += WALL_GRAVITY
#		velocity.y = min(velocity.y, 300)
#
#func apply_friction():
#	velocity.x = move_toward(velocity.x, 0, FRICTION)
#
#func apply_acceleration(amount):
#
#	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)
#
#func _on_jump_buffer_timer_timeout():
#	buffer_jump = false
#
#func _on_coyote_jump_timer_timeout():
#	coyote_jump = false
#
#func _on_wall_touched_timer_timeout():
#	wall_jump = false
#	print("WallJump")
#
#func _on_wall_slide_timer_timeout():
#	wall_slide = false
