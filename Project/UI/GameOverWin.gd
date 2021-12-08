extends Control

func _ready():
	Jukebox.play_win_chime()


func _on_MainMenuButton_pressed() -> void:
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res://UI/MainMenu.tscn") != OK:
		print ("An unexpected error occured while trying to switch to mainMenu scene")
