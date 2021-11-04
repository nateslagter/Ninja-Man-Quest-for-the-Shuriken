class_name Boss
extends KinematicBody2D



const gravity := 700
const jump_speed := -400

onready var initial_pos := Vector2(position.x,position.y)

var velocity := Vector2(50,0)
var switch_velocity = 50
var health := 3
var attacked := false
var moving := false

func _ready():
	$WaitTimer.start()
	scale.x *= -1

func _physics_process(delta : float) -> void:
	if !moving:
		$AnimationPlayer.play("Idle")
	else:
		var _ignored = move_and_slide(velocity,Vector2(0,0))
	velocity.y += gravity * delta
	

func _on_MoveTimer_timeout():
	$WaitTimer.start()
	moving = false
	scale.x *= -1
	

func _on_WaitTimer_timeout():
	moving = true
	$AnimationPlayer.play("Walk")
	switch_velocity *= -1
	velocity = Vector2(switch_velocity, 0)
	$MoveTimer.start()



func _on_Hitbox_area_entered(area : Area2D) -> void:
	if area.name == "SwordHitbox":
		health -= 1
	if health == 0:
		queue_free()
