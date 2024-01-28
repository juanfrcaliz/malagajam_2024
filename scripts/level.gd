extends Node

var level_number = 0
var tutorial_texts = ["Press A / D to move", "Press R to bark", "Press Space to jump"]
var tutorial_index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	show_message(tutorial_texts[0])
	tutorial_index += 1

func _physics_process(_delta):
	$MarginContainer2.position = Vector2($Pug.position.x - 120, $Pug.position.y - 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func show_message(message):
	$MarginContainer2/Label.text = message
	var tween = get_tree().create_tween()
	tween.tween_property($MarginContainer2, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)
	$TutorialCooldown.start()
	
func hide_message():
	var tween = get_tree().create_tween()
	tween.tween_property($MarginContainer2, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
	tween.connect("finished", on_hide_message_ended)


func _on_box_dog_entered():
	$ToySound.play()
	$Pug.change_mobility(false)
	$Pug.show_ball(true)
	transitionLevel()


func _on_box_dog_exited():
	$Pug.change_mobility(true)
	
func transitionLevel():
	print(level_number)
	if level_number == 0:
		var tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/ColorRect, "color:a", 1, 1).set_trans(Tween.TRANS_SINE)
		get_node("hab_Delante").hide()
		get_node("PuertaAbierta").show()
		get_node("puerta_salon").set_collision_layer_value(1, 0)
		tween.connect("finished", on_tween_finished)
	if level_number == 1:
		var tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/ColorRect, "color:a", 1, 1).set_trans(Tween.TRANS_SINE)
		get_node("Pug").wear_tutu()
		get_node("Pug").show_ball(false)
		tween.connect("finished", on_tween_finished)
		

func on_tween_finished():
	#play right sound
	level_number += 1

func _on_toy_sound_finished():
	print('terminao')
	var tween2 = get_tree().create_tween()
	tween2.tween_property($CanvasLayer/ColorRect, "color:a", 0, 1).set_trans(Tween.TRANS_SINE)

func on_hide_message_ended():
	if tutorial_index < tutorial_texts.size():
		show_message(tutorial_texts[tutorial_index])
		tutorial_index += 1

func _on_tutorial_cooldown_timeout():
	hide_message()
	
