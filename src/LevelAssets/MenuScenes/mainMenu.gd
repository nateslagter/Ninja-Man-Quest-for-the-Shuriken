extends Control

func _on_PlayButton_pressed() -> void:
	Globals.score = 0
	Globals.health = 3
	if get_tree().change_scene("res://src/LevelAssets/LevelOne/LevelOne.tscn") != OK:
		print ("An unexpected error occured while trying to switch to LevelOne scene")
