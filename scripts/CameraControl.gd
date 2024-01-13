extends Node2D

@export var camera : Camera2D
var zoom_speed = 0.01
var move_speed = 2000.0

func _process(delta):
	var movement = Vector2.ZERO
	var zoom = 0

	# Handle camera movement with arrow keys
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	if Input.is_action_pressed("zoom"):
		zoom += 1
	if Input.is_action_pressed("dezoom"):
		zoom -= 1
	if Input.is_action_pressed("print"):
		print_debug("zoom: ", camera.zoom)
		print_debug("offset: ", camera.offset)

	# Normalize the movement vector to ensure consistent speed in all directions
	movement = movement.normalized() * move_speed * delta
	zoom = zoom * zoom_speed * delta

	# Move the camera
	camera.offset += movement
	camera.zoom += Vector2(zoom, zoom)
