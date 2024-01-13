extends Node

@export var tile_scene: PackedScene

var hexagon_size = Vector2(30, 30)  # Adjust the size as needed
var grid_size = Vector2(300, 200)  # Adjust the size of your grid

func _ready():
	var tile_grid = generate_tile_grid()
	generate_terrain(tile_grid)

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

func generate_terrain(grid):
	var height = FastNoiseLite.new()
	var temperature = FastNoiseLite.new()
	var precipitation = FastNoiseLite.new()
	
	set_perlin_noise(height, 0.01)
	set_perlin_noise(temperature, 0.04)
	set_perlin_noise(precipitation, 0.03)
	
	for row in range(grid_size.y):
		for col in range(grid_size.x):
			grid[row][col].average_temperature = scale_temperature(temperature.get_noise_2d(row, col)) + temperature_modifier(row, grid_size.y)
			grid[row][col].average_precipitation = scale_precipitation(precipitation.get_noise_2d(row, col))
			grid[row][col].height = scale_height(height.get_noise_2d(row, col))
			grid[row][col].set_height()
			grid[row][col].set_type()
			grid[row][col].recolor()

func set_perlin_noise(noise, frequency):
	noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	noise.set_seed(randi()%100000)
	noise.set_frequency(frequency)

func scale_temperature(t):
	return ((t + 1) / 2) * 65 - 25

func temperature_modifier(x, height): 
	return sin((x / height) * 2 * PI - PI/2) * 15

func scale_precipitation(p):
	var prec = ((p + 1) / 2) * 450 - 100
	return prec if prec >= 0 else 0

func scale_height(h):
	return ((h + 1) / 2) * 7750 - 3750

func hex_to_pixel(hex_pos):
	var x = hexagon_size.x * sqrt(3.0) * (hex_pos.x + 0.5 * (hex_pos.y % 2))
	var y = 1.5 * hexagon_size.y * hex_pos.y
	return Vector2(x,y)
