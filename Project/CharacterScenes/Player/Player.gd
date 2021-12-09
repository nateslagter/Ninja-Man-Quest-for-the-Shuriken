class_name Player
extends KinematicBody2D

const RUN_SPEED := 200
const JUMP_SPEED := -320
const GRAVITY := 700

var damageable := true
var velocity = Vector2()


func attack() -> void:
	$AnimationPlayer.play("Attack")


func _on_Area2D_body_entered(body : Node2D) -> void:
	if (body.is_in_group("EnemyAttack") or body.is_in_group("BossAttack")) and damageable:
		Globals.health -= 1
		damageable = false
		$InvincibilityTimer.start()
		$DamageAnimation.play("Damaged")
		if Globals.health == 0:
			$Sprite.hide()
			$SceneTransition/AnimationPlayer.play("SweepIn")
			yield($SceneTransition/AnimationPlayer, "animation_finished")
			if get_tree().change_scene("res://UI/GameOverLose.tscn") != OK:
				print ("An unexpected error occured while trying to switch to gameOverLose scene")


func _on_InvincibilityTimer_timeout() -> void:
	damageable = true
