extends Control


func _ready() -> void:
	Jukebox.play_win_chime()
	$Score.text = "Score: %d" % Globals.score


func _on_MainMenuButton_pressed() -> void:
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://UI/MainMenu.tscn") != OK:
		print ("An unexpected error occured while trying to switch to mainMenu scene")
