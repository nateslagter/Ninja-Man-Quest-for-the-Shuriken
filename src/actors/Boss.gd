extends KinematicBody2D


onready var initial_pos := Vector2(position.x,position.y)

const gravity := 700
const jump_speed := -400

var velocity := Vector2(200,0)
var switch_velocity = 200
var jumping := false
var direction_to_move := "right"
var moving := false
	

func _physics_process(delta : float) -> void:
	velocity.y += gravity * delta
	if moving:
		velocity = move_and_slide(velocity,Vector2(0,-1))


func _on_MoveTimer_timeout():
	switch_velocity *= -1
	velocity = Vector2(switch_velocity,0)
	scale.x *= -1
	moving = true
		


func _on_JumpTimer_timeout():
	velocity.y += jump_speed
