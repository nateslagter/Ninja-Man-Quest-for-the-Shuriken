extends Control



func _on_MainMenuButton_pressed():
	if get_tree().change_scene("res://src/levels/mainMenu.tscn") != OK:
		print ("An unexpected error occured while trying to switch to mainMenu scene")
