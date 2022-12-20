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
@export var WALL_JUMPS = 1
@export var MAX_SPEED = 150
@export var ACCELERATION = 12
@export var FRICTION = 10
@export var GRAVITY = 5
@export var FALL_GRAVITY = 2
@export var PUSH_DISTANCE = 100
@export var WALL_GRAVITY = 50

@onready var coyoteJumpTimer := $CoyoteJumpTimer
var coyote_jump = false

@onready var jumpBufferTimer := $JumpBufferTimer
var buffer_jump = false

@onready var wallTouchedTimer := $WallTouchedTimer
var wall_jump = false

@onready var wallSlideTimer := $WallSlideTimer
var wall_slide = false


func _physics_process(delta):
	
	var input = Vector2.ZERO
	input.x = Input.get_axis("Left", "Right")
	input.y = Input.get_axis("Jump", "Slide")
	
	match state:
		MOVE: move_state(input)
		CLIMB:climb_state(input)
		
func move_state(input):
	apply_gravity(GRAVITY)
	
	if not horizontal_move(input):
		apply_friction()
		
	if horizontal_move(input):
		apply_acceleration(input.x)

	if can_jump():
		input_jump(input)
	else:
		input_jump_release()
		input_double_jump()
		buffered_jump()
		fast_fall()
		input_wall_jump(input)
		
	var was_on_floor = is_on_floor() #Remember Floor State
	move_and_slide() #Do Movement and get next State
	var just_left_ground = not is_on_floor() and was_on_floor
	do_coyote_jump(just_left_ground)

func climb_state(input): #to be added
	pass
		
func can_jump():
	return is_on_floor() or coyote_jump

func input_jump(input):
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
	if is_on_wall() and wall_slide:
		print("slide")
		velocity.y = WALL_GRAVITY
		
	if velocity.y > 0 and not is_on_wall():
		velocity.y += FALL_GRAVITY
func input_double_jump():
	if Input.is_action_just_pressed("Jump") and DOUBLE_JUMPS > 0:
		velocity.y = JUMP_FORCE
		DOUBLE_JUMPS-=1

func do_coyote_jump(just_left_ground):
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		coyoteJumpTimer.start()

func input_wall_jump(input):
	if is_on_wall() and Input.is_action_just_pressed("Jump") and input.x != 0:
		wall_slide = true
		wallSlideTimer.start()
		velocity.y = JUMP_FORCE
		wall_jump=true
		velocity.x = -input.x * PUSH_DISTANCE
		wallTouchedTimer.start()
			
func horizontal_move(input):
	return input.x != 0

func apply_gravity(amount):
		# Add the gravity.
		#if not is_on_wall(): 
		velocity.y += amount
		#else: velocity.y += WALL_GRAVITY
		velocity.y = min(velocity.y, 300)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)

func apply_acceleration(amount):
		
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)

func _on_jump_buffer_timer_timeout():
	buffer_jump = false

func _on_coyote_jump_timer_timeout():
	coyote_jump = false


func _on_wall_touched_timer_timeout():
	wall_jump = false
	print("WallJump")


func _on_wall_slide_timer_timeout():
	wall_slide = false
