extends Control

func _on_PlayButton_pressed():
	if get_tree().change_scene("res://src/levels/testLevel.tscn") != OK:
		print ("An unexpected error occured while trying to switch to testLevel scene")
