extends Node2D


func _on_LevelEnd_area_entered(_area : Area2D):
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://Project/UI/GameOverWin.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverWin scene")


func _on_Killbox_area_entered(_area):
	$Player.hide()
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://Project/UI/GameOverLose.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverLose scene")
