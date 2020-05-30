extends Control



func _ready():
	pass # Replace with function body.



func _on_NewGAmeButton_pressed():
	get_tree().change_scene("res://LevelOne.tscn")


func _on_EXITBUTTON_pressed():
	get_tree().quit()
