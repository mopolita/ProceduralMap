extends Node

func generate_terrain(grid, grid_size):
	var height = FastNoiseLite.new()
	var temperature = FastNoiseLite.new()
	var precipitation = FastNoiseLite.new()
	
	set_noise(height, 0.01)
	set_noise(temperature, 0.04)
	set_noise(precipitation, 0.03)
	
	for row in range(grid_size.y):
		for col in range(grid_size.x):
			grid[row][col].average_temperature = scale_temperature(temperature.get_noise_2d(row, col)) + temperature_modifier(row, grid_size.y)
			grid[row][col].average_precipitation = scale_precipitation(precipitation.get_noise_2d(row, col))
			grid[row][col].height = scale_height(height.get_noise_2d(row, col))
			grid[row][col].set_height()
			grid[row][col].set_type()
			grid[row][col].recolor()

func set_noise(noise, frequency):
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
