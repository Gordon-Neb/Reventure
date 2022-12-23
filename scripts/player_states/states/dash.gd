extends MoveState

@export var dash_time = 0.4

var current_dash_time: float = 0
var dash_direction: int = 1

# Upon entering the state, set dash direction to either current input or the direction the player is facing if no input is pressed
func enter() -> void:
	super.enter()
	
	current_dash_time = dash_time
	
	if Input.is_action_pressed("Left"):
		dash_direction = -1
	elif Input.is_action_pressed("Right"):
		dash_direction = 1

# Override MoveState input() since we don't want to change states based checked player input
func input(_event: InputEvent) -> BaseState:
	return null

# Move in the dash_direction every frame
func get_movement_input() -> int:
	return dash_direction

# Track how long we've been dashing so we know when to exit
func process(delta: float) -> BaseState:
	current_dash_time -= delta

	if current_dash_time > 0:
		return null

	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		if Input.is_action_pressed("Sprint"):
			return run_node
		return walk_node
	return idle_node

