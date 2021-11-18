extends "res://src/StateMachineInterface/State.gd"

onready var animation_player = get_node("../AnimationPlayer")
onready var sprite = get_node("../Sprite")

var waiting : bool = true
var knockback_direction : float
var player_health = Globals.health
var player_body


func _ready() -> void:
	call_deferred("set_state",States.IDLE)
	
	
func _process(_delta) -> void:
	if Globals.health != player_health:
		state = States.IDLE
		_enter_state(state)
		player_health = Globals.health


func _logic(delta : float) -> void:
	apply_gravity(delta)
	parent.move_and_slide(parent.velocity,Vector2.UP)
	_switch_direction()
		

func _transition(delta : float) -> void:
	match state:
		States.KNOCKBACK:
			parent.position.x += knockback_direction
			parent.velocity = parent.move_and_slide(parent.velocity,Vector2.UP)
			apply_gravity(delta)

			
func _enter_state(state) -> void:
	match state:
		States.IDLE:
			parent.velocity.x = 0
			animation_player.play("Idle")
		States.RUNNING:
			animation_player.play("Walk")
		States.KNOCKBACK:
			if parent.global_position.x <= player_body.global_position.x:
				knockback_direction = -2.5
			elif parent.global_position.x > player_body.global_position.x:
				knockback_direction =  2.5
			parent.velocity.y += -150
			
			
func _switch_direction() -> void:
	if state != States.DODGING:
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


func _on_PlayerDetectionSquare_area_entered(area : Area2D) -> void:
	state = States.RUNNING
	_enter_state(state)


func _on_PlayerDetectionSquare_area_exited(area : Area2D) -> void:
	state = States.IDLE
	_enter_state(state)


func _on_PlayerAttackRange_area_entered(area):
	animation_player.play("Attack")
