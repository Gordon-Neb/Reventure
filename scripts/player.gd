extends CharacterBody2D

#State Machine
enum {
	MOVE,
	CLIMB
}
var state = MOVE

@export var JUMP_FORCE = -210
@export var JUMP_RELEASE_FORCE = -70
@export var DOUBLE_JUMPS = 1
@export var MAX_SPEED = 150
@export var ACCELERATION = 12
@export var FRICTION = 10
@export var GRAVITY = 5
@export var FALL_GRAVITY = 2

@onready var coyoteJumpTimer := $CoyoteJumpTimer
var coyote_jump = false

@onready var jumpBufferTimer := $JumpBufferTimer
var buffer_jump = false


func _physics_process(delta):
	
	var input = Vector2.ZERO
	input.x = Input.get_axis("Left", "Right")
	input.y = Input.get_axis("Jump", "Slide")
	
	match state:
		MOVE: move_state(input)
		CLIMB:climb_state(input)
		
func move_state(input):
	apply_gravity()
	
	if not horizontal_move(input):
		apply_friction()
		
	if horizontal_move(input):
		apply_acceleration(input.x)

	if can_jump():
		input_jump()
	else:
		input_jump_release()
		input_double_jump()
		buffered_jump()
		fast_fall()
		
	var was_on_floor = is_on_floor() #Remember Floor State
	move_and_slide()
	do_coyote_jump(not is_on_floor() and was_on_floor)
	
func climb_state(input): #to be added
	pass

func can_jump():
	return is_on_floor() or coyote_jump

func input_jump():
	if Input.is_action_just_pressed("Jump") or buffer_jump:
		velocity.y = JUMP_FORCE
		buffer_jump = false

func input_jump_release():
	if Input.is_action_just_released("Jump") and velocity.y < JUMP_RELEASE_FORCE:
		velocity.y = JUMP_RELEASE_FORCE

func buffered_jump():
	if Input.is_action_just_pressed("Jump"):
		buffer_jump = true
		jumpBufferTimer.start()

func fast_fall():
	if velocity.y > 0:
		velocity.y += FALL_GRAVITY

func input_double_jump():
	if Input.is_action_just_pressed("Jump") and DOUBLE_JUMPS > 0:
		velocity.y = JUMP_FORCE
		DOUBLE_JUMPS-=1

func do_coyote_jump(just_left_ground):
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		coyoteJumpTimer.start()
		print("test")
func horizontal_move(input):
	return input.x != 0

func apply_gravity():
		# Add the gravity.
		velocity.y += GRAVITY
		velocity.y = min(velocity.y, 300)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)

func _on_jump_buffer_timer_timeout():
	buffer_jump = false

func _on_coyote_jump_timer_timeout():
	coyote_jump = false
