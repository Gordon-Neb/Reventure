extends BaseState


#Get Node State References Boiler Plate Code
@onready var idle_node = $"../idle"
@onready var walk_node = $"../walk"
@onready var run_node = $"../run"
@onready var jump_node = $"../jump"
@onready var fall_node = $"../fall"
@onready var dash_node = $"../dash"

func enter() -> void:
	super.enter()
	player.velocity.x = 0

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
	player.velocity.y += player.gravity
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	return null
