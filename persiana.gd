extends Area2D

var blinder_down: bool = true

func _ready():
	get_node("blinder_up").hide()
	get_node("blinder_down").show()


func _on_body_entered(body):
	if blinder_down:
		get_node("blinder_up").show()
		get_node("blinder_down").hide()
