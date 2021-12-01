class_name Enemy
extends KinematicBody2D

signal enemy_hit(area)

var velocity := Vector2(0,0)
var health := 2
var attacked := false


func _on_Area2D_area_entered(area : Area2D) -> void:
	attacked = true
	if area.name == "SwordHitbox":
		health -= 1
		emit_signal("enemy_hit",area)
		if health == 0:
			queue_free()


func _on_Area2D_area_exited(_area : Area2D) -> void:
	attacked = false


