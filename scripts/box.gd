extends Node

signal dog_entered
signal dog_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(_body):
	dog_entered.emit()


func _on_area_2d_body_exited(_body):
	dog_exited.emit()
