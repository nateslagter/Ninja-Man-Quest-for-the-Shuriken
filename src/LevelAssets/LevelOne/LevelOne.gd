extends Node2D


func _ready():
	pass # Replace with function body.


func _on_EndOfLevel_area_entered(_area):
	if get_tree().change_scene("res://src/LevelAssets/MenuScenes/gameOverWin.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverWin scene")
