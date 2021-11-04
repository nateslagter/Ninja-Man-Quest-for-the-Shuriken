class_name Player
extends KinematicBody2D


const run_speed := 200
const jump_speed := -300
const gravity := 700

var velocity := Vector2()
var jumping := false
var attacking := false

func get_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x -= run_speed
		$Sprite.scale.x = -1
		if jumping == false and attacking == false:
			$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("move_right"):
		velocity.x += run_speed
		$Sprite.scale.x = 1
		if jumping == false and attacking == false:
			$AnimationPlayer.play("Walk")
	if Input.is_action_just_pressed("jump"):
		if jumping == false and is_on_floor():
			jumping = true
			$AnimationPlayer.play("Jump")
			velocity.y += jump_speed
	if Input.is_action_just_pressed("attack"):
		attacking = true
		$AnimationPlayer.play("Attack")
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		if jumping == false and attacking == false:
			$AnimationPlayer.play("Idle")
		
		
func _physics_process(delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.y += gravity * delta
	if jumping == true and is_on_floor():
		jumping = false
		$AnimationPlayer.play("Idle")


func _on_Area2D_body_entered(body : Node2D) -> void:
	if body is Boss or body.name =="AttackHitbox" or body.name == "EnemyHitbox":
		Globals.health -= 1
		if Globals.health == 0:
			queue_free()
			

func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "Attack":
		$AnimationPlayer.play("Idle")
		attacking = false
