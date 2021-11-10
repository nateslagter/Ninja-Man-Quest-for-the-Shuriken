extends "res://src/StateMachine/State.gd"

onready var animation_player = get_node("../AnimationPlayer")
onready var sprite = get_node("../Sprite")

var attacking := false
var jumping := false

func _ready() -> void:
	call_deferred("set_state",States.IDLE)


func _logic(delta : float) -> void:
	if state != States.ATTACKING:
		get_input(delta)
		
func get_input(delta : float) -> void:
	parent.velocity.x = 0
	if Input.is_action_pressed("move_left"):
		parent.velocity.x -= parent.run_speed
	if Input.is_action_pressed("move_right"):
		parent.velocity.x += parent.run_speed
	if Input.is_action_just_pressed("jump"):
		if jumping == false:
			parent.velocity.y += parent.jump_speed
	if Input.is_action_just_pressed("attack"):
		parent.attack()
	if !parent.is_on_floor():
		parent.velocity.y += parent.gravity * delta
	_switch_direction()
	parent.velocity = parent.move_and_slide(parent.velocity,Vector2.UP)
	
func _switch_direction() -> void:
	if parent.velocity.x < 0:
		sprite.set_flip_h(true)
	if parent.velocity.x >= 0:
		sprite.set_flip_h(false)
	

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
			
		
func _enter_state(state) -> void:
	match state:
		States.IDLE:
			animation_player.play("Idle")
		States.JUMPING:
			jumping = true
			animation_player.play("Jump")
		States.RUNNING:
			animation_player.play("Walk")
			
			
func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "Attack":
		if parent.velocity.x != 0:
			state = States.RUNNING
			_enter_state(state)
		else:
			state = States.IDLE
			_enter_state(state)
