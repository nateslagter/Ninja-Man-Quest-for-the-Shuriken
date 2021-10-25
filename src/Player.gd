extends KinematicBody2D

signal player_hit

const run_speed := 100
const jump_speed := -300
const gravity := 700

var velocity := Vector2()
var jumping := false
var health := 3


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


func reduce_health() -> void:
	health -= 1
	_check_game_over()
	
	
func _check_game_over() -> void:
	if health == 0:
		$".".call_deferred("free")


func _on_AttackHitbox_area_entered(area : Area2D) -> void:
	if area.has_method("_physics_process"):
		reduce_health()
		emit_signal("player_hit")
		$AnimationPlayer.play("Hit")
