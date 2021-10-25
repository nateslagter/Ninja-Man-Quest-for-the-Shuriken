extends Camera2D

onready var player := get_node("../../Player")

func _process(_delta) -> void:
	if get_node_or_null("../../Player"):
		position.x = player.position.x
