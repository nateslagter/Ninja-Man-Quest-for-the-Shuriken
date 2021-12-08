extends Node2D


func _on_LevelEnd_area_entered(_area : Area2D) -> void:
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://LevelScenes/LevelTwo/LevelTwo.tscn") != OK:
			print ("An unexpected error occured while trying to switch to LevelTwo scene")


func _on_Killbox_body_entered(body : Node2D) -> void:
	if body.is_in_group("Player"):
		$Player.hide()
		$SceneTransition/AnimationPlayer.play("SweepIn")
		yield($SceneTransition/AnimationPlayer, "animation_finished")
		if get_tree().change_scene("res://UI/GameOverLose.tscn") != OK:
				print ("An unexpected error occured while trying to switch to gameOverLose scene")
	elif body.is_in_group("Enemy"):
		body.queue_free()
