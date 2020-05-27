extends KinematicBody2D

const SPEED = 30 
const GRAVITY = 15
const FLOOR = Vector2(0,-1)
var vel = Vector2()
var direction = 1

func kill():
	queue_free()

func _physics_process(delta):
	vel.x = SPEED * direction
	vel.y += GRAVITY
	vel = move_and_slide(vel,FLOOR)
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
