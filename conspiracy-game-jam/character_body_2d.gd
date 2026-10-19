extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animatedsprite: AnimatedSprite2D = $AnimatedSprite2D

func get_input():
	var input_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = input_direction * SPEED
	if input_direction.x < 0 :
		animatedsprite.flip_h = true
		animatedsprite.play("default")
	elif input_direction.x > 0:
		animatedsprite.flip_h = false
		animatedsprite.play("default")
	else:
		animatedsprite.stop()

func _physics_process(delta):
	get_input()
	move_and_slide()
