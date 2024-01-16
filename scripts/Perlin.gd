extends Node

func generate_terrain(grid, grid_size):
	var height = FastNoiseLite.new()
	var temperature = FastNoiseLite.new()
	var precipitation = FastNoiseLite.new()
	
	set_noise(height, 0.01)
	set_noise(temperature, 0.035)
	set_noise(precipitation, 0.025)
	
	set_fractal(precipitation, FastNoiseLite.FRACTAL_FBM, 3, 0.3)
	set_fractal(temperature, FastNoiseLite.FRACTAL_FBM, 3, 0.2)
	set_fractal(height, FastNoiseLite.FRACTAL_FBM, 5, 0.15)

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

func set_fractal(noise, type, octaves, weight):
	noise.set_fractal_type(type)
	noise.set_fractal_octaves(octaves)
	noise.set_fractal_weighted_strength(weight)

func scale_temperature(t):
	return ((t + 1) / 2) * 65 - 25

func temperature_modifier(x, height): 
	return sin((x / height) * 2 * PI - PI/2) * 15

func scale_precipitation(p):
	var prec = ((p + 1) / 2) * 400 - 100
	return prec if prec >= 0 else 0

func scale_height(h):
	return ((h + 1) / 2) * 8500 - 4000
