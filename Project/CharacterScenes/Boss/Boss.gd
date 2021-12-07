extends KinematicBody2D

var health : int = 3



func _on_Hitbox_area_entered(area : Area2D) -> void:
	if area.is_in_group("PlayerAttack"):
		print("damaged")
		health -= 1
		$DamageAnimation.play("Damaged")
