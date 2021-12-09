extends "res://StateMachineInterface/State.gd"

onready var animation_player = get_node("../AnimationPlayer")
onready var boss_boundary_detector = get_node("../BossBoundaryDetector")
onready var sprite = get_node("../Sprite")

var attack_on_cooldown := false
var velocity := Vector2(100,0)


func _ready() -> void:
	call_deferred("set_state",States.RUNNING)


func _logic(delta : float) -> void:
	if boss_boundary_detector.is_colliding():
		if boss_boundary_detector.get_collider().is_in_group("BossBoundaries"):
			velocity = Vector2(-velocity.x,velocity.y)
			get_node("../WaitTimer").start()
			boss_boundary_detector.scale.x *= -1
			get_node("../AttackHitbox").scale.x *= -1
			state = States.IDLE
			_enter_state(state)
		elif boss_boundary_detector.get_collider().is_in_group("Player"):
			if !attack_on_cooldown:
				state = States.ATTACKING
				animation_player.play("Attack")
				attack_on_cooldown = true
				get_node("../AttackCooldownTimer").start()
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


func _on_AnimationPlayer_animation_finished(_anim_name : String) -> void:
	state = States.RUNNING
	_enter_state(state)


func _on_AttackCooldownTimer_timeout():
	attack_on_cooldown = false
