extends "res://src/StateMachine/State.gd"

func _ready():
	call_deferred("set_state",States.IDLE)


func _logic(delta : float) -> void:
	parent.get_input(delta)


func _transition(delta : float):
	match States:
		States.IDLE:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return States.JUMPING
				elif parent.velocity.y > 0:
					return States.FALLING
			elif parent.velocity.x != 0:
				return States.RUNNING
		States.RUNNING:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return States.JUMPING
				elif parent.velocity.y > 0:
					return States.FALLING
			elif parent.velocity.x == 0:
				return States.IDLE
		States.IDLE:
			if parent.is_on_floor():
				return States.IDLE
			elif parent.velocity.x >= 0:
				return States.FALLING
		States.FALLING:
			if parent.is_on_floor():
				return States.IDLE
			elif parent.velocity.y < 0:
				return States.JUMP
		
func _enter_state(state) -> void:
	match state:
		States.IDLE:
			print("hello")
	
func _exit_state(state) -> void:
	pass
