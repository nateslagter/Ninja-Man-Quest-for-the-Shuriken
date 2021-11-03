extends Node

signal score_changed(score)

var score : int = 0 setget _set_score

func _set_score(value:int)->void:
	score = value
	emit_signal("score_changed", score)
