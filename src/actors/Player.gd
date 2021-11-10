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
	
func attack() -> void:
	$AnimationPlayer.play("Attack")


func _on_Area2D_body_entered(body : Node2D) -> void:
	if body is Boss or body.name =="AttackHitbox" or body.name == "EnemyHitbox":
		Globals.health -= 1
		$DamageAnimation.play("Damaged")
		if Globals.health == 0:
			queue_free()
			if get_tree().change_scene("res://src/levels/gameOverLoss.tscn") != OK:
				print ("An unexpected error occured while trying to switch to gameOverLoss scene")
			
