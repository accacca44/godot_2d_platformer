extends KinematicBody2D

const SPEED = 30 
const GRAVITY = 15
const FLOOR = Vector2(0,-1)
var vel = Vector2()
var direction = 1
var is_dead = false

func kill():
	is_dead = true
	vel = Vector2(0,0)
	$AnimatedSprite.play("death")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	print("DEAD")

func _physics_process(delta):
	if is_dead == false:
		vel.x = SPEED * direction
		vel.y += GRAVITY
		vel = move_and_slide(vel,FLOOR)
		
		$AnimatedSprite.play("slide")
		
		if vel.y == 0:
			if is_on_wall():
				direction *= -1
		
			if $RayCast2D.is_colliding() == false:
				direction *= -1
				$RayCast2D.position.x *= -1
			if direction == -1:
				$AnimatedSprite.flip_h = true
			if direction == 1:
				$AnimatedSprite.flip_h = false


func _on_Timer_timeout():
	queue_free()
