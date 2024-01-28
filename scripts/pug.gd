extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const PUSH_FORCE = 10.0
var can_push = true
var have_ball = false
var tutu = false

var allow_input = true

signal interact

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	get_node("Node2D/pelota").hide()


func _physics_process(delta):
	if allow_input:
		if not is_on_floor():
			velocity.y += gravity * delta

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if velocity.x > 0:
				$Node2D.scale.x = 1
			else:
				$Node2D.scale.x = -1
				
			if !$WalkAudio.playing:
				$WalkAudio.play()
			
			if tutu:
				%AnimatedSprite2D.play("walk_tutu")
			elif have_ball:
				%AnimatedSprite2D.play("walk_ball")
			else:
				%AnimatedSprite2D.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			$WalkAudio.stop()
			if tutu:
				%AnimatedSprite2D.play("idle_tutu")
			elif have_ball:
				%AnimatedSprite2D.play("idle_ball")

			else:
				%AnimatedSprite2D.play("idle")

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
			
	else:
		$BarkAudio.stop()
		$WalkAudio.stop()
		
func bark():
	if !$BarkAudio.playing:
		$BarkAudio.play()

func change_mobility(state):
	if state == false:
		have_ball = true
		
	can_push = state
	
func show_ball(state):
	if state:
		$Node2D/pelota.show()
	else:
		$Node2D/pelota.hide()
		
func set_allow_input(state):
	allow_input = state

func wear_tutu():
	tutu = true
