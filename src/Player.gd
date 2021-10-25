extends KinematicBody2D


const run_speed := 100
const jump_speed := -300
const gravity := 700

var velocity := Vector2()
var jumping := false


func get_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = true
		if !jumping:
			$AnimatedSprite.play("Run")
	if Input.is_action_pressed("move_right"):
		velocity.x += run_speed
		$AnimatedSprite.flip_h = false
		if !jumping:
			$AnimatedSprite.play("Run")
	if Input.is_action_just_pressed("jump"):
		if jumping == false and is_on_floor():
			$JumpFX.play()
			jumping = true
			velocity.y += jump_speed
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left"):
		$AnimatedSprite.play("Idle")
		

func _physics_process(delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.y += gravity * delta
	if jumping == true and is_on_floor():
		jumping = false
