extends CanvasLayer



func _process(delta):
	$Score.text = "Score: %d" % Globals.score
	$Health.text = "Health: %d" % Globals.health
