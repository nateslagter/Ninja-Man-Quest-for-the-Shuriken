extends Control

func _ready():
	Jukebox.play_main_music()


func _on_PlayButton_pressed() -> void:
	Globals.score = 0
	Globals.health = 5
	$SceneTransition/AnimationPlayer.play("SweepIn")
	yield($SceneTransition/AnimationPlayer, "animation_finished")
	if get_tree().change_scene("res:///UI/HowToPlay.tscn") != OK:
		print ("An unexpected error occured while trying to switch to HowToPlay scene")
