class_name Player
extends KinematicBody2D


const run_speed := 200
const jump_speed := -300
const gravity := 700

var velocity := Vector2()
var jumping := false
var attacking := false
var previously_dodged := false
var ableToMove := true
var dash_frames := 0
var dashMultiplier := 2
var damageable = true


func get_input() -> void:
	velocity.x = 0
	if ableToMove: 
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

		if Input.is_action_just_pressed("attack") and jumping == false:
			ableToMove = false
			attacking = true
			$AnimationPlayer.play("Attack")

		if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
			if jumping == false and attacking == false:
				$AnimationPlayer.play("Idle")

		if Input.is_action_pressed("dodge_backwards") and !previously_dodged:
			$AnimationPlayer.play("Dodge")
			velocity.x = 0
			ableToMove = false
			previously_dodged = true
			dash_frames = 10
			velocity.x = velocity.x * dashMultiplier
			$DodgeCooldownTimer.start()
	if dash_frames > 0:
		dash_frames -= 1
		if $Sprite.scale.x == 1:
			velocity.x += -400
		elif $Sprite.scale.x == -1:
			velocity.x += 400


func _physics_process(delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.y += gravity * delta
	if jumping == true and is_on_floor():
		jumping = false
		$AnimationPlayer.play("Idle")


func _on_Area2D_body_entered(body : Node2D) -> void:
	if body is Boss or body.name =="AttackHitbox" or body.name == "EnemyHitbox":
		if damageable:
			Globals.health -= 1
			damageable = false
			$DamageCooldown.start()
		if Globals.health == 0:
			queue_free()
			

func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "Attack" or anim_name == "Dodge":
		$AnimationPlayer.play("Idle")
		attacking = false
		ableToMove = true


func _on_DodgeCooldownTimer_timeout() -> void:
	print("Ready to dodge!")
	previously_dodged = false


func _on_DamageCooldown_timeout():
	damageable = true
