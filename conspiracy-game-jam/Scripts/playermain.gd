extends CharacterBody2D

@export var SPEED: int = 15
@export var JUMP_FORCE: int = 160
@export var GRAVITY: int = 900

@onready var anim = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer

var was_on_floor: bool = false

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")

	velocity.x = direction * SPEED

	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var can_jump = is_on_floor() or not coyote_timer.is_stopped()

	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = -JUMP_FORCE
		coyote_timer.stop()
		anim.play("jump")
	elif Input.is_action_just_pressed("superjump") and can_jump:
		velocity.y = -JUMP_FORCE * 1.5 
		coyote_timer.stop()
		anim.play("megajump")

	if is_on_floor():
		if direction != 0:
			anim.play("walk")
		else:
			anim.play("idle")

	was_on_floor = is_on_floor()
	move_and_slide()

	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_timer.start()
