extends Node

@export var map: Node2D

func hex_to_pixel(hex_pos, hex_size):
	var x = hex_size.x * sqrt(3.0) * (hex_pos.x + 0.5 * (hex_pos.y % 2))
	var y = 1.5 * hex_size.y * hex_pos.y
	return Vector2(x,y)

func _on_reload_button_pressed():
	map.generate_map(map.world_type)

func _on_world_type_item_selected(index):
	map.world_type = index as Enums.WorldType
