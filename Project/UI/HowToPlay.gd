extends Control

func _on_PlayButton_pressed() -> void:
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://LevelScenes/LevelOne/LevelOne.tscn") != OK:
		print ("An unexpected error occured while trying to switch to LevelOne scene")
