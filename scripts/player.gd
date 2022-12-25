extends CharacterBody2D
class_name Player

#@export var gravity = 4
@onready var states = $state_manager

@onready var coyoteJumpTimer := $CoyoteJumpTimer

@onready var jumpBufferTimer := $JumpBufferTimer

@onready var wallTouchedTimer := $WallTouchedTimer

@onready var wallSlideTimer := $WallSlideTimer


var playerStats = preload("res://Player_Stat_Data.tres")

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)


func _on_jump_buffer_timer_timeout():
	playerStats.BUFFERED_JUMP = false
	print(playerStats.BUFFERED_JUMP)


func _on_coyote_jump_timer_timeout():
	pass # Replace with function body.


func _on_wall_touched_timer_timeout():
	pass # Replace with function body.


func _on_wall_slide_timer_timeout():
	pass # Replace with function body.
