class_name Enemy
extends KinematicBody2D


onready var initial_pos := Vector2(position.x,position.y)

var velocity := Vector2(50,0)
var switch_velocity = 50
var health := 3
var attacked := false


func _physics_process(delta):
	if !attacked:
		if position.x > initial_pos.x + 50:
			switch_velocity *= -1
			velocity = Vector2(switch_velocity, 0)
		elif position.x < initial_pos.x - 50:
			switch_velocity *= -1
			velocity = Vector2(switch_velocity, 0)
		var _ignored = move_and_slide(velocity,Vector2(0,0))


func _on_Area2D_area_entered(area):
	attacked = true
	if area.name == "SwordHitbox":
		health -= 1
	if health == 0:
		queue_free()

func _on_Area2D_area_exited(area):
	attacked = false
