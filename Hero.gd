extends KinematicBody2D

const SPEED = 100
const GRAVITY = 15
const MAX_SPEED = 1000
const JUMP_FORCE = -250
const FLOOR = Vector2(0,-1)
const MAX_JUMPS = 1

var vel = Vector2() 
var jumps_left 


func get_input_from_user():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	
	if jump:
		if jumps_left > 0:
			vel.y = JUMP_FORCE
			jumps_left -= 1
	
	if right:
		vel.x = SPEED
		$HerosSprite.flip_h = false
		$HerosSprite.play("walk")
	elif left:
		vel.x = -SPEED
		$HerosSprite.flip_h = true
		$HerosSprite.play("walk")



func _physics_process(delta):
	vel.x = 0
	get_input_from_user()

	if vel.x == 0 or is_on_wall():
		$HerosSprite.play("idle")
	#gravity
	vel.y += GRAVITY
	if vel.y < -MAX_SPEED:
		vel.y = -MAX_SPEED
	#doubleJump
	if is_on_floor():
		jumps_left = MAX_JUMPS 
		
	else:
		if vel.y > GRAVITY:
			$HerosSprite.stop()
			$HerosSprite.play("fall")
			
		if vel.y < 0:
			$HerosSprite.stop()
			$HerosSprite.play("jump")
	#actually moving
	vel = move_and_slide(vel,FLOOR)
	



