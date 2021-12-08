extends AudioStreamPlayer

var main_music = load("res://Common/SFX/Level1Theme.ogg")
var boss_music = load ("res://Common/SFX/Level2Theme.ogg")

func play_main_music():
	stream = main_music
	play()


func play_boss_music():
	stream = boss_music
	play()
