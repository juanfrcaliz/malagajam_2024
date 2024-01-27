extends Node

var level_number = 0
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
	transitionLevel()


func _on_box_dog_exited():
	$Pug.change_mobility(true)
	
func transitionLevel():
	if level_number == 0:
		var tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/ColorRect, "color:a", 1, 1).set_trans(Tween.TRANS_SINE)
		$ToySound.play()
		level_number += 1


func _on_audio_stream_player_2d_finished():
	print('terminao')
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/ColorRect, "color:a", 0, 1).set_trans(Tween.TRANS_SINE)
