extends Control

func _on_MainMenuButton_pressed() -> void:
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://src/LevelScenes/MenuScenes//mainMenu.tscn") != OK:
		print ("An unexpected error occured while trying to switch to mainMenu scene")
