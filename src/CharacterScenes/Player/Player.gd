class_name Player
extends KinematicBody2D

signal player_hit(body)

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
		Globals.health -= 1
		if Globals.health > 0:
			damageable = false
			$InvincibilityTimer.start()
			emit_signal("player_hit",body)
		elif Globals.health == 0:
			$DamageAnimation.play("Dead")
			$SceneTransition/AnimationPlayer.play("SweepIn")
			yield($SceneTransition/AnimationPlayer, "animation_finished")
			if get_tree().change_scene("res://src/LevelAssets/MenuScenes/gameOverLoss.tscn") != OK:
				print ("An unexpected error occured while trying to switch to gameOverLoss scene")


func _on_InvincibilityTimer_timeout() -> void:
	damageable = true
