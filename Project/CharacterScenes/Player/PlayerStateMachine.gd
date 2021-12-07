extends "res://StateMachineInterface/State.gd"

var attacking := false
var jumping := false
var slide_velocity = Vector2(-2500,0)
var enemy_body : Area2D
var knockback_direction : float

onready var animation_player = get_node("../AnimationPlayer")
onready var damage_player = get_node("../DamageAnimation")
onready var sprite = get_node("../Sprite")
onready var sword_hitbox = get_node("../Sprite/SwordHitbox")


func _ready() -> void:
	call_deferred("set_state",States.IDLE)


func _logic(delta : float) -> void:
	if state == States.KNOCKBACK or state == States.DODGING:
		pass
	else:
		get_input(delta)
		apply_gravity(delta)
	parent.velocity = parent.move_and_slide(parent.velocity,Vector2.UP)


func apply_gravity(delta : float) -> void:
	if !parent.is_on_floor():
		parent.velocity.y += parent.GRAVITY * delta


func get_input(_delta : float) -> void:
	parent.velocity.x = 0
	if Input.is_action_pressed("move_left"):
		parent.velocity.x -= parent.RUN_SPEED
	if Input.is_action_pressed("move_right"):
		parent.velocity.x += parent.RUN_SPEED
	if Input.is_action_just_pressed("jump"):
		if jumping == false:
			parent.velocity.y += parent.JUMP_SPEED
	if Input.is_action_just_pressed("attack"):
		parent.attack()
	if Input.is_action_just_pressed("dodge_backwards"):
		if parent.is_on_floor():
			state = States.DODGING
			_enter_state(state)
	_switch_direction()


func _switch_direction() -> void:
	if state != States.DODGING:
		if parent.velocity.x < 0:
			sprite.set_flip_h(true)
			sword_hitbox.scale.x = -1
			slide_velocity = Vector2(2500,0)
		if parent.velocity.x > 0:
			sprite.set_flip_h(false)
			sword_hitbox.scale.x = 1
			slide_velocity = Vector2(-2500,0)


func _transition(delta : float):
	match state:
		States.IDLE:
			if jumping == true:
				jumping = false
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return States.JUMPING
				elif parent.velocity.y > 0:
					return States.FALLING
			elif parent.velocity.x != 0:
				return States.RUNNING
		States.RUNNING:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return States.JUMPING
				elif parent.velocity.y > 0:
					return States.FALLING
			elif parent.velocity.x == 0:
				return States.IDLE
		States.JUMPING:
			if parent.is_on_floor():
				return States.IDLE
			elif parent.velocity.y >= 0:
				return States.FALLING
		States.FALLING:
			if parent.is_on_floor():
				return States.IDLE
			elif parent.velocity.y < 0:
				return States.JUMPING
		States.DODGING:
			parent.velocity.x = 0
			if sprite.flip_h:
				parent.position.x += 8
			else:
				parent.position.x -= 8
		States.KNOCKBACK:
			parent.position.x += knockback_direction
			parent.velocity = parent.move_and_slide(parent.velocity,Vector2.UP)
			apply_gravity(delta)


func _enter_state(state : int) -> void:
	match state:
		States.IDLE:
			animation_player.play("Idle")
		States.JUMPING:
			jumping = true
			animation_player.play("Jump")
		States.RUNNING:
			animation_player.play("Walk")
		States.FALLING:
			animation_player.play("Fall")
		States.DODGING:
			animation_player.play("Dodge")
		States.KNOCKBACK:
			damage_player.play("Damaged")
			if parent.global_position.x <= enemy_body.global_position.x:
				knockback_direction = -2.5
			elif parent.global_position.x > enemy_body.global_position.x:
				knockback_direction =  2.5
			parent.velocity.y += parent.JUMP_SPEED / 2


func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "Attack":
		if parent.velocity.x != 0:
			state = States.RUNNING
			_enter_state(state)
		else:
			state = States.IDLE
			_enter_state(state)
	if anim_name == "Dodge":
		if parent.velocity.x != 0:
			state = States.RUNNING
			_enter_state(state)
		else:
			state = States.IDLE
			_enter_state(state)


func _create_knockback(body) -> void:
	enemy_body = body
	get_node("../KnockbackTimer").start()
	parent.velocity = Vector2(0,0)
	state = States.KNOCKBACK
	_enter_state(state)


func _on_KnockbackTimer_timeout() -> void:
	state = States.IDLE
	_enter_state(state)
