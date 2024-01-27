extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_box_dog_entered():
	$ToySound.play()
	$Pug.change_mobility(false)
	$Pug.show_ball()


func _on_box_dog_exited():
	$Pug.change_mobility(true)
