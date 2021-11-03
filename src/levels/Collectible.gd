extends Area2D


func _on_Collectible_body_entered(body):
	if body is Player:
		Globals.score += 100
		queue_free()
