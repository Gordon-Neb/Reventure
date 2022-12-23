extends Node
class_name BaseState

# Pass in a reference to the player's kinematic body so that it can be used by the state
var player: Player 
#export animation if wanted

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
