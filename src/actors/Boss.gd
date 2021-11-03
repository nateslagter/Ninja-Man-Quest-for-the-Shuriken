extends KinematicBody2D


onready var initial_pos := Vector2(position.x,position.y)

var velocity := Vector2(200,0)
var switch_velocity = 200

func _physics_process(delta : float) -> void:
	if position.x > initial_pos.x + 200:
		velocity = Vector2(-switch_velocity,0)
		scale.x *= -1
	elif position.x < initial_pos.x - 200:
		velocity = Vector2(switch_velocity,0)
		scale.x *= -1
	var _ignored = move_and_slide(velocity,Vector2(0,-1))
