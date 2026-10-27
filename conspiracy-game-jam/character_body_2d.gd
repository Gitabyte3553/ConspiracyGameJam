extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animatedsprite: AnimatedSprite2D = $AnimatedSprite2D

func get_input():
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	velocity.y = 0

	if direction < 0:
		animatedsprite.play("moving_left")
	elif direction > 0:
		animatedsprite.flip_h = false
		animatedsprite.play("default")
	else:
		animatedsprite.stop()

func _physics_process(delta):
	get_input()
	move_and_slide()
