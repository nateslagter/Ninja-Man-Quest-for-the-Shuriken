extends Node2D


func _ready():
	$SceneTransition/AnimationPlayer.play("SweepOut")
	

func _on_EndOfLevel_area_entered(_area):
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://src/LevelAssets/MenuScenes/gameOverWin.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverWin scene")
