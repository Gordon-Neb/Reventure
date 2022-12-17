extends CharacterBody2D


const MAX_SPEED = 100
const ACCELERATION = 1
const JUMP_VELOCITY = -400.0
var jumpCount = 2
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump", true) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("Right"):
			velocity.x = MAX_SPEED
			print(velocity.x)
	elif Input.is_action_pressed("Left"):
			velocity.x = -MAX_SPEED
			print(velocity.x)
	else:
		velocity.x = move_toward(velocity.x, 0, MAX_SPEED)
		
	move_and_slide()
