extends "res://src/StateMachine/State.gd"

func _ready():
	call_deferred("set_state",States.IDLE)

func _logic(deta : float) -> void:
	parent.get_input(delta)


func _transition(delta : float) -> void:
	pass

	
func _enter_state(state) -> void:
	pass

	
func _exit_state(state) -> void:
	pass
