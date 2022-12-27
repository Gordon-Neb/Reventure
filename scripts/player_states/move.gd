extends BaseState
class_name MoveState

func enter() -> void:
	super.enter()
	playerStats.CAN_JUMP = false

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
		
	var move = get_movement_input()
#	if move < 0:
#		player.animations.flip_h = true
#	elif move > 0:
#	player.animations.flip_h = false
	
	if move == 0:
		return idle_node


		
	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("Left"):
		return -1
	elif Input.is_action_pressed("Right"):
		return 1
	
	return 0
