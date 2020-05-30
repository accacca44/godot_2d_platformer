extends KinematicBody2D

const SPEED = 100
const GRAVITY = 15
const MAX_SPEED = 1000
const JUMP_FORCE = -250
const FLOOR = Vector2(0,-1)
const MAX_JUMPS = 1
const FIREBALL = preload("res://Fireball.tscn")

var vel = Vector2()
var jumps_left 
var is_shooting = false

func get_input_from_user():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	var shoot = Input.is_action_just_pressed("shoot_fireball")
	var exit = Input.is_action_just_pressed("quit_game")
	
	if exit:
		get_tree().change_scene("res://TitleScreen.tscn")
		
		
	if jump:
		if jumps_left > 0:
			vel.y = JUMP_FORCE
			jumps_left -= 1
	
	if right:
		vel.x = SPEED
		if !is_shooting:
			$HerosSprite.flip_h = false
			$HerosSprite.play("walk")
			if sign($FireballSpawn.position.x) == -1:
				$FireballSpawn.position.x *= -1
		
	elif left:
		vel.x = -SPEED
		if !is_shooting:
			$HerosSprite.flip_h = true
			$HerosSprite.play("walk")
			if sign($FireballSpawn.position.x) == 1:
				$FireballSpawn.position.x *= -1

		
	if shoot and !is_shooting:
		is_shooting = true
		$HerosSprite.play("shoot")
		var ball = FIREBALL.instance()
		if sign($FireballSpawn.position.x) == 1:
			ball.set_dir(1)
		else:
			ball.set_dir(-1)
		get_parent().add_child(ball)
		ball.position = $FireballSpawn.global_position



func _physics_process(delta):
	vel.x = 0
	get_input_from_user()

	if (vel.x == 0 or is_on_wall()) and !is_shooting:
		$HerosSprite.play("idle")
	#gravity
	vel.y += GRAVITY
	if vel.y < -MAX_SPEED:
		vel.y = -MAX_SPEED
	#doubleJump
	if is_on_floor():
		jumps_left = MAX_JUMPS 
		
	elif !is_shooting:
		if vel.y > GRAVITY:
			$HerosSprite.stop()
			$HerosSprite.play("fall")
			
		if vel.y < 0:
			$HerosSprite.stop()
			$HerosSprite.play("jump")
	#jumpkill
	if $RayCast2D.is_colliding() == true:
		$RayCast2D.get_collider().kill()
		vel.y = -SPEED*3
		jumps_left = 0
	#actually moving
	vel = move_and_slide(vel,FLOOR)

func _on_HerosSprite_animation_finished():
	is_shooting = false


