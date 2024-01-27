extends StaticBody2D

var seesaw_left: bool = true

func _ready():
	get_node("seesaw_right").hide()
	get_node("seesaw_left").show()
	get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
	get_node("seesaw_collision_left").set_collision_layer_value(1, 1)


func _on_left_switch_body_entered(body):
		if not seesaw_left:
			get_node("seesaw_right").hide()
			get_node("seesaw_left").show()
			get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
			get_node("seesaw_collision_left").set_collision_layer_value(1, 1)
			seesaw_left = true


func _on_right_switch_body_entered(body):
	if seesaw_left:
		get_node("seesaw_right").show()
		get_node("seesaw_left").hide()
		get_node("seesaw_collision_left").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_right").set_collision_layer_value(1, 1)
		seesaw_left = false


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
