extends "res://Project/StateMachineInterface/State.gd"

onready var animation_player = get_node("../AnimationPlayer")
onready var boss_boundary_detector = get_node("../BossBoundaryDetector")
onready var sprite = get_node("../Sprite")


var velocity = Vector2(100,0)



func _ready() -> void:
	call_deferred("set_state",States.IDLE)


func _logic(delta : float) -> void:
	if boss_boundary_detector.is_colliding():
		print("colliding")
		if boss_boundary_detector.get_collider().is_in_group("BossBoundaries"):
			velocity = Vector2(-velocity.x,velocity.y)
			get_node("../WaitTimer").start()
			boss_boundary_detector.scale.x *= -1
			get_node("../AttackHitbox").scale.x *= -1
		elif boss_boundary_detector.get_collider().is_in_group("Player"):
			state = States.ATTACKING
			animation_player.play("Attack")
	_apply_gravity(delta)
	if state == States.RUNNING:
		parent.move_and_slide(velocity,Vector2.UP)
	_switch_direction()

	
func _apply_gravity(delta : float) -> void:
	if !parent.is_on_floor():
		velocity.y += 700 * delta


func _switch_direction() -> void:
	if velocity.x < 0:
		sprite.set_flip_h(true)
	if velocity.x > 0:
		sprite.set_flip_h(false)
		
func _transition(_delta : float):
	match state:
		States.IDLE:
			if state != States.KNOCKBACK:
				if velocity.x != 0:
					return States.RUNNING
		States.RUNNING:
			if state != States.KNOCKBACK:
				if velocity.x == 0:
					return States.IDLE
	
	
func _enter_state(_new_state) -> void:
	match state:
		States.IDLE:
			animation_player.play("Idle")
		States.ATTACKING:
			animation_player.play("Attack")
		States.RUNNING:
			animation_player.play("Walk")
			
	

func _on_WaitTimer_timeout() -> void:
	state = States.RUNNING
	_enter_state(state)


func _on_AnimationPlayer_animation_finished(anim_name):
	state = States.RUNNING
	_enter_state(state)
