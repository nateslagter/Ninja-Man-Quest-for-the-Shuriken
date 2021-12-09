class_name Enemy
extends KinematicBody2D

signal enemy_hit(area)

var health := 2


func _on_Area2D_area_entered(area : Area2D) -> void:
	if area.name == "SwordHitbox":
		health -= 1
		emit_signal("enemy_hit",area)
		if health == 0:
			Globals.score += 100
			queue_free()

