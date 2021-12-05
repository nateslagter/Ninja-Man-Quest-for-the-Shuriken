extends Node2D


func _on_TeleportBox_area_entered(_area):
	Globals.health -= 1
	if Globals.health < 1:
		$Player.hide()
		$SceneTransition/AnimationPlayer.play("SweepIn")
		yield($SceneTransition/AnimationPlayer, "animation_finished")
		if get_tree().change_scene("res://Project/UI/GameOverLose.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverLose scene")
	else:
		$Player.position = Vector2(35, 70)
		$Player/DamageAnimation.play("Damaged")


func _on_Killbox_area_entered(_area):
	$Player.hide()
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://Project/UI/GameOverLose.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverLose scene")
