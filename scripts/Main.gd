extends Node

@export var tile_scene: PackedScene

var hexagon_size = Vector2(30, 30)  # Adjust the size as needed
var grid_size = Vector2(300, 200)  # Adjust the size of your grid
var tile_grid

func _ready():
	tile_grid = generate_tile_grid()
	Perlin.generate_terrain(tile_grid, grid_size)

func generate_tile_grid():
	var col_array = []
	for row in range(grid_size.y):
		var row_array = []
		for col in range(grid_size.x):
			var tile = tile_scene.instantiate()
			tile.position = hex_to_pixel(Vector2i(col, row))
			row_array.append(tile)
			add_child(tile)
		col_array.append(row_array)
	return col_array

func hex_to_pixel(hex_pos):
	var x = hexagon_size.x * sqrt(3.0) * (hex_pos.x + 0.5 * (hex_pos.y % 2))
	var y = 1.5 * hexagon_size.y * hex_pos.y
	return Vector2(x,y)


func _on_reload_button_pressed():
	Perlin.generate_terrain(tile_grid, grid_size)
