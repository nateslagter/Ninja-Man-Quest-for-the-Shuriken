extends Node2D

func _ready() -> void:
	Jukebox.play_boss_music()


func _on_TeleportBox_area_entered(_area) -> void:
	Globals.health -= 1
	if Globals.health < 1:
		$Player.hide()
		$SceneTransition/AnimationPlayer.play("SweepIn")
		yield($SceneTransition/AnimationPlayer, "animation_finished")
		if get_tree().change_scene("res://UI/GameOverLose.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverLose scene")
	else:
		$Player.position = Vector2(35, 70)
		$Player/DamageAnimation.play("Damaged")


func _on_Killbox_area_entered(_area) -> void:
	$Player.hide()
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://UI/GameOverLose.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverLose scene")


func _on_Boss_boss_defeated() -> void:
	$Player.hide()
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://UI/GameOverWin.tscn") != OK:
			print ("An unexpected error occured while trying to switch to gameOverLose scene")
