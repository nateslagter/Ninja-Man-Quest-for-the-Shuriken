class_name Collectible
extends Area2D


func _on_Collectible_body_entered(body : Node2D) -> void:
	if body is Player:
		Globals.score += 1
		queue_free()
