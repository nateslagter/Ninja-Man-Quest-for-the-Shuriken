extends CanvasLayer

var _displayed_score : float = 0

func _process(delta):
	_displayed_score  = lerp(_displayed_score, Globals.score, 0.3)
	$Label.text = "Score: %d" % ceil(_displayed_score)
	
	var difference = Globals.score - _displayed_score
