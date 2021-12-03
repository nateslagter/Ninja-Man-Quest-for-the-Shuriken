extends "res://Project/StateMachineInterface/State.gd"

var waiting : bool = true
var knockback_direction : float
var player_health : int = Globals.health
var player_body = Area2D

onready var animation_player = get_node("../AnimationPlayer")
onready var sprite = get_node("../Sprite")
onready var knockback_timer = get_node("../KnockbackTimer")
onready var front_detector = get_node("../FrontDetector")
onready var back_detector = get_node("../BackDetector")
onready var attack_range_detector = get_node("../AttackRangeDetector")


func _ready() -> void:
	call_deferred("set_state",States.IDLE)


func _logic(delta : float) -> void:
	if front_detector.is_colliding():
		if front_detector.get_collider().name == "Player":
			state = States.RUNNING
			_enter_state(state)
		
	apply_gravity(delta)
	parent.move_and_slide(parent.velocity,Vector2.UP)
	_switch_direction()
	_check_player_health()


func _check_player_health() -> void:
	if Globals.health != player_health:
		state = States.IDLE
		_enter_state(state)
		player_health = Globals.health


func _transition(delta : float) -> void:
	match state:
		States.KNOCKBACK:
			parent.position.x += knockback_direction
			parent.velocity = parent.move_and_slide(parent.velocity,Vector2.UP)
			apply_gravity(delta)


func _enter_state(state : int) -> void:
	match state:
		States.IDLE:
			parent.velocity.x = 0
			animation_player.play("Idle")
		States.RUNNING:
			animation_player.play("Walk")
		States.KNOCKBACK:
			knockback_timer.start()
			if parent.global_position.x <= player_body.global_position.x:
				knockback_direction = -2.5
			elif parent.global_position.x > player_body.global_position.x:
				knockback_direction =  2.5
			parent.velocity.y += -150


func _switch_direction() -> void:
	if parent.velocity.x < 0:
		sprite.set_flip_h(true)
	if parent.velocity.x > 0:
		sprite.set_flip_h(false)


func apply_gravity(delta : float) -> void:
	if !parent.is_on_floor():
		parent.velocity.y += 700 * delta


func _on_Enemy_enemy_hit(body : Area2D) -> void:
	player_body = body
	parent.velocity = Vector2(0,0)
	state = States.KNOCKBACK
	_enter_state(state)


func _on_KnockbackTimer_timeout():
	state = States.IDLE
	_enter_state(state)
