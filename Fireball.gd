extends Area2D


const SPEED = 180
var mov = Vector2()
var direction = 1

func set_dir(dir):
	direction = dir
	if direction == -1:
		$FireballPix.flip_h = true 


func _physics_process(delta):
	mov.x = SPEED * delta * direction
	translate(mov)




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Fireball_body_entered(body):
	if body.name != "Hero":
		if "Enemy" in body.name:
			body.kill()
		queue_free()
	



