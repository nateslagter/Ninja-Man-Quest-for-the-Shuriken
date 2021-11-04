extends CanvasLayer


func _process(_delta) -> void:
	$Score.text = "Score: %d" % Globals.score
	$Health.text = "Health: %d" % Globals.health
