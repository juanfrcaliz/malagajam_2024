extends StaticBody2D

var can_flip : bool = true

var seesaw_pos: String = "top"

signal box_fall

func _ready():
	get_node("seesaw_top").show()
	get_node("seesaw_right").hide()
	get_node("seesaw_left").hide()
	get_node("seesaw_collision_top").set_collision_layer_value(1, 1)
	get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
	get_node("seesaw_collision_left").set_collision_layer_value(1, 0)

func switch_to_right():
	get_node("seesaw_right").hide()
	get_node("seesaw_left").show()
	get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
	get_node("seesaw_collision_left").set_collision_layer_value(1, 1)
	seesaw_pos = "right"
	$BalacinSound.play()

func _on_top_switch_body_entered(body):
	if seesaw_pos == "top" && body.name == "Pug":
		get_node("seesaw_top").hide()
		get_node("seesaw_right").hide()
		get_node("seesaw_left").show()
		get_node("seesaw_collision_top").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_left").set_collision_layer_value(1, 1)
		seesaw_pos = "left"
		$CaidaBalancinSound.play()

func _on_left_switch_body_entered(body):
	if seesaw_pos == "left" && can_flip:
		print(body.velocity)
		switch_to_right()
	if body.velocity.y > 20 && not can_flip:
		#animacion final
		print('caca')
		can_flip = true
		box_fall.emit()


func _on_right_switch_body_entered(_body):
	if seesaw_pos == "right":
		get_node("seesaw_right").show()
		get_node("seesaw_left").hide()
		get_node("seesaw_collision_left").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_right").set_collision_layer_value(1, 1)
		seesaw_pos = "left"
		$BalacinSound.play()
		



func _on_detect_ball_body_entered(body):
	if body.name == "Esfera":
		can_flip = false
	


func _on_detect_ball_body_exited(body):
	if body.name == "Esfera":
		can_flip = true
