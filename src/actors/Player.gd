class_name Player
extends KinematicBody2D


const run_speed := 300
const jump_speed := -400
const gravity := 700

var velocity := Vector2()
var jumping := false

func get_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x -= run_speed
	if Input.is_action_pressed("move_right"):
		velocity.x += run_speed
	if Input.is_action_just_pressed("jump"):
		if jumping == false and is_on_floor():
			jumping = true
			velocity.y += jump_speed
		
func _physics_process(delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.y += gravity * delta
	if jumping == true and is_on_floor():
		jumping = false


func _on_Area2D_body_entered(body):
	if body is Boss:
		Globals.health -= 1
		if Globals.health == 0:
			queue_free()
			
