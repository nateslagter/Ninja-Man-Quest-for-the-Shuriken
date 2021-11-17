extends "res://src/StateMachine/State.gd"

onready var animation_player = get_node("../AnimationPlayer")
onready var sprite = get_node("../Sprite")
onready var wait_timer = get_node("../WaitTimer")
onready var run_timer = get_node("../RunTimer")

var waiting : bool = true
var player_health = Globals.health


func _ready() -> void:
	call_deferred("set_state",States.IDLE)
	
func _process(_delta) -> void:
	if Globals.health != player_health:
		state = States.IDLE
		_enter_state(state)
		run_timer.stop()
		wait_timer.start()
		waiting = true
		player_health = Globals.health


func _logic(delta : float) -> void:
	if !waiting:
		var _ignored = parent.move_and_slide(parent.velocity,Vector2(0,0))
	parent.velocity.y += parent.gravity * delta
	parent.move_and_slide(Vector2(0,parent.velocity.y),Vector2(0,0))
		

func _transition(delta : float):
	match state:
		States.IDLE:
			if !waiting:
				return States.RUNNING
		States.RUNNING:
			if waiting:
				return States.IDLE
			
			
func _enter_state(state) -> void:
	match state:
		States.IDLE:
			animation_player.play("Idle")
		States.RUNNING:
			animation_player.play("Walk")
			

func _on_WaitTimer_timeout():
	waiting = false
	run_timer.start()
	

func _on_RunTimer_timeout():
	waiting = true
	if 	sprite.is_flipped_h() == true:
		sprite.set_flip_h(false)
	else:
		sprite.set_flip_h(true)
	wait_timer.start()
	parent.velocity = Vector2(-parent.velocity.x,parent.velocity.y)
