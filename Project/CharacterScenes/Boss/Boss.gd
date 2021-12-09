extends KinematicBody2D

signal boss_defeated()

var health : int = 6


func _on_Hitbox_area_entered(area : Area2D) -> void:
	if area.is_in_group("PlayerAttack"):
		health -= 1
		$DamageAnimation.play("Damaged")
		if health == 0:
			Globals.score += 500
			emit_signal("boss_defeated")
			queue_free()
