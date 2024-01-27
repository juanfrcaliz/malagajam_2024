extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 10.0
var can_push = true

signal interact

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	show_messages('Press A / D to move')

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = 0
		else:
			$AnimatedSprite2D.flip_h = 1
		
		$AnimatedSprite2D.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")

	move_and_slide()

	if can_push:
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)
				
	if Input.is_action_just_pressed("interact"):
		interact.emit()
		
	if Input.is_action_just_pressed("bark"):
		bark()
		
func bark():
	$AudioStreamPlayer2D.play()

func change_mobility(state):
	can_push = state
	
func show_messages(message):
	$MarginContainer/Label.text = message
	var tween = get_tree().create_tween()
	tween.tween_property($MarginContainer, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)
	$MessageCooldown.start()
	
func hide_message():
	var tween = get_tree().create_tween()
	tween.tween_property($MarginContainer, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
	
func _on_message_cooldown_timeout():
	hide_message()
