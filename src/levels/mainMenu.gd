extends Control

func _on_PlayButton_pressed():
	Globals.score = 0
	Globals.health = 5
	if get_tree().change_scene("res://src/levels/testLevel.tscn") != OK:
		print ("An unexpected error occured while trying to switch to testLevel scene")
