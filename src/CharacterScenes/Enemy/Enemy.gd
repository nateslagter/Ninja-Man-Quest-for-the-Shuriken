class_name Enemy
extends KinematicBody2D


const gravity := 700

var velocity := Vector2(100,0)
var health := 1
var attacked := false


func _on_Area2D_area_entered(area : Area2D) -> void:
	attacked = true
	if area.name == "SwordHitbox":
		health -= 1
	if health == 0:
		queue_free()


func _on_Area2D_area_exited(_area : Area2D) -> void:
	attacked = false
