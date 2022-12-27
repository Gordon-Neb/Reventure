extends Resource
class_name Player_Stat_Data
#Change test values in editor to take effect and later for perma in the code

@export var JUMP_FORCE = -210
@export var JUMP_RELEASE_FORCE = -70
@export var JUMPS_LEFT = 0
@export var MAX_JUMP_COUNT = 1
@export var WALL_JUMP = false
@export var CAN_JUMP = false #Should only be true while switching from jump to fall!
@export var BUFFERED_JUMP = false
@export var COYOTE_JUMP = false

@export var WALK_SPEED = 100
@export var RUN_SPEED = 200
@export var ACCELERATION = 8
@export var FRICTION = 20

@export var GRAVITY = 5
@export var FALL_GRAVITY = 10

@export var PUSH_DISTANCE = 50 #may need some adjustment!
@export var WALL_GRAVITY = 50


