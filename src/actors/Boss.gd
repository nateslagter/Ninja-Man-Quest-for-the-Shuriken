class_name Boss
extends KinematicBody2D



const gravity := 700
const jump_speed := -400

onready var initial_pos := Vector2(position.x,position.y)

var velocity := Vector2(150,0)
var switch_velocity = 150
var health := 20
var movable := true


func _physics_process(delta : float) -> void:
	if movable:
		$AnimationPlayer.play("Walk")
		if position.x > initial_pos.x + 200:
			scale.x *= -1
			$AnimationPlayer.play("Idle")
			switch_velocity *= -1
			velocity = Vector2(switch_velocity, 0)
			movable = false
			$WaitTimer.start()
		elif position.x < initial_pos.x - 200:
			scale.x *= -1
			$AnimationPlayer.play("Idle")
			switch_velocity *= -1
			velocity = Vector2(switch_velocity, 0)
			movable = false
			$WaitTimer.start()
		var _ignored = move_and_slide(velocity,Vector2(0,0))
	

func _on_Hitbox_area_entered(area : Area2D) -> void:
	if area.name == "SwordHitbox":
		health -= 1
		_attack()
	
	if health == 0:
		queue_free()


func _on_WaitTimer_timeout():
	movable = true


func _on_AttackTimer_timeout():
	$AnimationPlayer.play("Attack")


func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "Attack":
		$AnimationPlayer.play("Idle")


func _attack() -> void:
	$AnimationPlayer.play("Attack")
	$AttackCooldown.start()
