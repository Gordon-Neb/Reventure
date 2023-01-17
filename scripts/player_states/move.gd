extends BaseState
class_name MoveState

func enter() -> void:
	super.enter()
	player.anim.play("Walk_Right")
	playerStats.JUMPS_LEFT = playerStats.MAX_JUMP_COUNT # Reset Jumps
	playerStats.CAN_JUMP = false
	#playerStats.WALL_JUMP = true

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("Jump"):
		return jump_node
	
	if Input.is_action_just_pressed("Dash"):
		return dash_node

	return null

func physics_process(_delta: float) -> BaseState:
	player.velocity.y += playerStats.GRAVITY
	
	if !player.is_on_floor():
		return fall_node
		
	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("Left"):
		return -1
	elif Input.is_action_pressed("Right"):
		return 1
	
	return 0
