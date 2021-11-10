extends Node

enum States {IDLE,ATTACKING,RUNNING,FALLING, JUMPING}
var state 
var previous_state

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		_logic(delta)
		var transition = _transition(delta)
		if transition != null:
			set_state(transition)
			

func _logic(delta : float) -> void:
	pass

func _transition(delta : float) -> void:
	pass
	
func _enter_state(new_state) -> void:
	pass
	
func _exit_state(new_state) -> void:
	pass

func set_state(new_state) -> void:
	state = new_state
	if state != null:
		_enter_state(state)

	
