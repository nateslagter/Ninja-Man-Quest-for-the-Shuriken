class_name Player
extends KinematicBody2D


const run_speed := 200
const jump_speed := -300
const gravity := 700

var damageable := true
var velocity := Vector2()

	
func attack() -> void:
	$AnimationPlayer.play("Attack")


func _on_Area2D_body_entered(body : Node2D) -> void:
	if (body is Boss or body.name =="AttackHitbox" or body.name == "EnemyHitbox") and damageable:
		Globals.health -= 1
		damageable = false
		$InvincibilityTimer.start()
		$DamageAnimation.play("Damaged")
		if Globals.health == 0:
			queue_free()
			if get_tree().change_scene("res://src/levels/gameOverLoss.tscn") != OK:
				print ("An unexpected error occured while trying to switch to gameOverLoss scene")
			


func _on_InvincibilityTimer_timeout() -> void:
	damageable = true
