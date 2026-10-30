extends Node2D

@onready var camera = $CharacterBody2D/Camera2D
@onready var parallax1 = $Parallax2D2

# Called when the node enters the scene tree for the first time.

var parallax1_limit_end_x = 6000
var parallax1_limit_end_y = 10000000

func _ready():
	Transition.transition()
	await Transition.on_transition_finished
func _process(_delta):
	# Get the active viewport's size (essential because limits stop when the screen edge hits them)
	var viewport_size = get_viewport_rect().size
	
	# Calculate the absolute furthest point the camera center can travel 
	# before it hits the right and bottom edges
	var max_camera_x = parallax1_limit_end_x - (viewport_size.x / 2)
	var max_camera_y = parallax1_limit_end_y - (viewport_size.y / 2)

	# Check if the camera center has crossed or hit those thresholds
	if camera.global_position.x >= max_camera_x:
		# RIGHT edge limit has been reached!
		$AnimatedSprite2D.global_position = camera.global_position
		$AnimatedSprite2D.visible = true
		
	else:
		$AnimatedSprite2D.visible = false
	#print("not_showing")


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "default":
		$AnimatedSprite2D.stop()
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://Scenes/Tutorial/tutorial.tscn")


func _on_animated_sprite_2d_visibility_changed() -> void:
	$AnimatedSprite2D.play("default")
