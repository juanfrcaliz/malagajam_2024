extends StaticBody2D

var seesaw_pos: String = "top"

func _ready():
	get_node("seesaw_top").show()
	get_node("seesaw_right").hide()
	get_node("seesaw_left").hide()
	get_node("seesaw_collision_top").set_collision_layer_value(1, 1)
	get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
	get_node("seesaw_collision_left").set_collision_layer_value(1, 0)


func _on_top_switch_body_entered(body):
	if seesaw_pos == "top" && body.name == "Pug":
		get_node("seesaw_top").hide()
		get_node("seesaw_right").hide()
		get_node("seesaw_left").show()
		get_node("seesaw_collision_top").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_left").set_collision_layer_value(1, 1)
		seesaw_pos = "left"


func _on_left_switch_body_entered(body):
	if seesaw_pos == "left":
		get_node("seesaw_right").hide()
		get_node("seesaw_left").show()
		get_node("seesaw_collision_right").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_left").set_collision_layer_value(1, 1)
		seesaw_pos = "right"


func _on_right_switch_body_entered(body):
	if seesaw_pos == "right":
		get_node("seesaw_right").show()
		get_node("seesaw_left").hide()
		get_node("seesaw_collision_left").set_collision_layer_value(1, 0)
		get_node("seesaw_collision_right").set_collision_layer_value(1, 1)
		seesaw_pos = "left"
