extends RigidBody2D


var gravity = 800  # Ajusta el valor de la gravedad según sea necesario

func _process(delta):
	var gravity_vector = Vector2(0, gravity)
