class_name Player
extends KinematicBody2D


const RUN_SPEED := 200
const JUMP_SPEED := -300
const GRAVITY := 700

var damageable := true
var velocity = Vector2()
var ableToDogde := true


func attack() -> void:
	$AnimationPlayer.play("Attack")


func _on_Area2D_body_entered(body : Node2D) -> void:
	if (body is Boss or body.name =="AttackHitbox" or body.name == "EnemyHitbox") and damageable:
		print(body.global_position.x)
		print(global_position)
		Globals.health -= 1
		damageable = false
		$InvincibilityTimer.start()
		$DamageAnimation.play("Damaged")
		velocity.y = JUMP_SPEED / 2.0
		if global_position.x < body.global_position.x:
			velocity.x = -800
		elif global_position.x > body.global_position.x:
			velocity.x = 800
		if Globals.health == 0:
			queue_free()
			if get_tree().change_scene("res://src/levels/gameOverLoss.tscn") != OK:
				print ("An unexpected error occured while trying to switch to gameOverLoss scene")


func _on_InvincibilityTimer_timeout() -> void:
	damageable = true
