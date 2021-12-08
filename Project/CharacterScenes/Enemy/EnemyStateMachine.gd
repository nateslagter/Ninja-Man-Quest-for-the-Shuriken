extends "res://StateMachineInterface/State.gd"

onready var animation_player = get_node("../AnimationPlayer")
onready var sprite = get_node("../Sprite")
onready var knockback_timer = get_node("../KnockbackTimer")
onready var player_detector = get_node("../PlayerDetector")

var waiting : bool = true
var knockback_direction : float
var player_health : int = Globals.health
var player_body = Area2D
var velocity := Vector2(0,0)
var collider : Node2D
var able_to_attack : bool = true


func _ready() -> void:
	call_deferred("set_state",States.IDLE)


func _logic(delta : float) -> void:
	if player_detector.is_colliding():
		collider = player_detector.get_collider()
		if collider.position.x > parent.position.x and collider.position.x < parent.position.x + 15:
			if able_to_attack:
				state = States.ATTACKING
				_enter_state(state)
				get_node("../AttackCooldown").start()
				able_to_attack = false
		elif collider.position.x > parent.position.x:
			velocity.x = 100
	else:
		velocity = Vector2(0,velocity.y)
	apply_gravity(delta)
	if state != States.ATTACKING:
		parent.move_and_slide(velocity,Vector2.UP)
	_switch_direction()
	_check_player_health()


func _check_player_health() -> void:
	if Globals.health != player_health:
		state = States.IDLE
		_enter_state(state)
		player_health = Globals.health


func _transition(_delta : float):
	match state:
		States.KNOCKBACK:
			parent.position.x += knockback_direction
		States.IDLE:
			if velocity.x != 0:
					return States.RUNNING
		States.RUNNING:
			if velocity.x == 0:
					return States.IDLE


func _enter_state(state : int) -> void:
	match state:
		States.IDLE:
			velocity.x = 0
			animation_player.play("Idle")
		States.RUNNING:
			animation_player.play("Walk")
		States.KNOCKBACK:
			player_detector.enabled = false
			velocity.x = 0
			knockback_timer.start()
			if parent.global_position.x <= player_body.global_position.x:
				knockback_direction = -2.5
			elif parent.global_position.x > player_body.global_position.x:
				knockback_direction =  2.5
			velocity.y += -150
		States.ATTACKING:
			animation_player.play("Attack")


func _switch_direction() -> void:
	if velocity.x < 0:
		sprite.set_flip_h(true)
	if velocity.x > 0:
		sprite.set_flip_h(false)


func apply_gravity(delta : float) -> void:
	if !parent.is_on_floor():
		velocity.y += 700 * delta


func _on_Enemy_enemy_hit(body : Area2D) -> void:
	player_body = body
	velocity = Vector2(0,0)
	state = States.KNOCKBACK
	_enter_state(state)


func _on_KnockbackTimer_timeout():
	state = States.IDLE
	_enter_state(state)
	player_detector.enabled = true


func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "Attack":
		state = States.IDLE
		_enter_state(state)


func _on_AttackCooldown_timeout():
	able_to_attack = true
