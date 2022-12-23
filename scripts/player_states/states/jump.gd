extends BaseState

@export var jump_force = 200
@export var move_speed = 100

#Get Node State References Boiler Plate Code
@onready var idle_node = $"../idle"
@onready var walk_node = $"../walk"
@onready var run_node = $"../run"
@onready var jump_node = $"../jump"
@onready var fall_node = $"../fall"
@onready var dash_node = $"../dash"

func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter()
	player.velocity.y = -jump_force

func physics_process(_delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("Left"):
		move = -1
		#player.animations.flip_h = true
	elif Input.is_action_pressed("Right"):
		move = 1
		#player.animations.flip_h = false
	
	player.velocity.x = move * move_speed
	player.velocity.y += player.gravity
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	
	if player.velocity.y > 0:
		return fall_node

	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("Sprint"):
				return run_node
			return walk_node
		return idle_node
	return null
