extends "res://Project/StateMachineInterface/State.gd"

onready var animation_player = get_node("../AnimationPlayer")
onready var boss_boundary_detector = get_node("../BossBoundaryDetector")

var velocity = Vector2(100,0)

func _ready():
	call_deferred("set_state",States.IDLE)

func _logic(_delta : float) -> void:
	print(boss_boundary_detector.is_colliding())
	if boss_boundary_detector.is_colliding():
		if boss_boundary_detector.get_collider().is_in_group("BossBoundaries"):
			print("detected")
		else:
			print("colliding, not detecting area")
	parent.position.x += 1


func _transition(_delta : float):
	return null
	
	
func _enter_state(_new_state) -> void:
	match state:
		States.IDLE:
			animation_player.play("Idle")
		States.ATTACKING:
			animation_player.play("Attack")
		States.RUNNING:
			animation_player.play("Walk")
			
	
	
func _exit_state(_new_state) -> void:
	pass

func _on_WaitTimer_timeout() -> void:
	state = States.RUNNING
	_enter_state(state)
