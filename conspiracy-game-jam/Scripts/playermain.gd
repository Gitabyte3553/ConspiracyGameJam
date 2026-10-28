extends CharacterBody2D

@export var SPEED : int = 15
@export var JUMP_FORCE: int = 160
@export var GRAVITY: int = 900

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			anim.play("walk")
	else:
		velocity.x = 0
		if is_on_floor():
			anim.play("idle")

	if direction == 1:
		anim.flip_h = false
	elif direction == -1:
		anim.flip_h = true

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	elif not is_on_floor() and Input.is_action_just_pressed("superjump"):
		var GRAVITY = 300
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_FORCE
		anim.play("jump")
	elif Input.is_action_just_pressed("superjump") and is_on_floor():
		
		velocity.y -= JUMP_FORCE
		anim.play("megajump")

	move_and_slide()
