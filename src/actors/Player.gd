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


func get_input(delta : float) -> void:
	velocity.x = 0
	if ableToMove: 
		if Input.is_action_pressed("move_left"):
			velocity.x -= run_speed
		if Input.is_action_pressed("move_right"):
			velocity.x += run_speed
		if Input.is_action_just_pressed("jump"):
			$AnimationPlayer.play("Jump")
			velocity.y += jump_speed
		if Input.is_action_just_pressed("attack"):
			ableToMove = false
			attacking = true
			$AnimationPlayer.play("Attack")
	velocity = move_and_slide(velocity,Vector2(0,-1))
	velocity.y += gravity * delta


func _on_Area2D_body_entered(body : Node2D) -> void:
	if body is Boss or body.name =="AttackHitbox" or body.name == "EnemyHitbox":
		if damageable:
			Globals.health -= 1
			$DamageAnimation.play("Damaged")
			damageable = false
			$DamageCooldown.start()
		if Globals.health == 0:
			queue_free()
			if get_tree().change_scene("res://src/levels/gameOverLoss.tscn") != OK:
				print ("An unexpected error occured while trying to switch to gameOverLoss scene")
			

func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "Attack" or anim_name == "Dodge":
		$AnimationPlayer.play("Idle")
		attacking = false
		ableToMove = true


