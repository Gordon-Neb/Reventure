extends Node
class_name BaseState

#Get Node State References Boiler Plate Code
@onready var idle_node = $"../idle"
@onready var walk_node = $"../walk"
@onready var run_node = $"../run"
@onready var jump_node = $"../jump"
@onready var fall_node = $"../fall"
@onready var dash_node = $"../dash"
@onready var slide_node = $"../slide"
# Pass in a reference to the player's kinematic body so that it can be used by the state
var player: Player 
#export animation if wanted
var playerStats = preload("res://Player_Stat_Data.tres")

func enter() -> void:
	#insert animation
	pass
	
func exit() -> void:
	#exit out of state
	pass

func input(_event: InputEvent) -> BaseState:
	return null

func process(_delta: float) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	return null
