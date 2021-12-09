extends AudioStreamPlayer

var main_music := load("res://Common/SFX/Level1Theme.ogg")
var boss_music := load ("res://Common/SFX/Level2Theme.ogg")
var win_chime := load("res://Common/SFX/WinChime.wav")
var lose_chime := load("res://Common/SFX/LoseChime.wav")


func play_main_music():
	stream = main_music
	play()


func play_boss_music():
	stream = boss_music
	play()


func play_win_chime():
	stream = win_chime
	play()


func play_lose_chime():
	stream = lose_chime
	play()
