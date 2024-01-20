extends Node

var temperature = FastNoiseLite.new()
var precipitation = FastNoiseLite.new()
var height_noise = FastNoiseLite.new()

var moisture_noise = FastNoiseLite.new()
var cavern_layout_noise = FastNoiseLite.new()
var depth_noise = FastNoiseLite.new()

func generate_tile(world_type, x, y, height):
	var tiles
	if (world_type == Enums.WorldType.OVERWORLD):
		tiles =  [scale_temperature(temperature.get_noise_2d(x, y)) + temperature_modifier(y, height), 
				scale_precipitation(precipitation.get_noise_2d(x, y)), 
				scale_height(height_noise.get_noise_2d(x, y))]
	else:
		tiles =  [absf(cavern_layout_noise.get_noise_2d(x, y)) * 100 - 14, 
				scale_moisture(moisture_noise.get_noise_2d(x, y)), 
				scale_depth(depth_noise.get_noise_2d(x, y))]
	return tiles

func setup(world_type):
	if (world_type == Enums.WorldType.OVERWORLD):
		set_noise(height_noise, 0.009)
		set_noise(temperature, 0.015)
		set_noise(precipitation, 0.015)

		set_fractal(precipitation, FastNoiseLite.FRACTAL_FBM, 3, 0.4)
		set_fractal(temperature, FastNoiseLite.FRACTAL_FBM, 3, 0.3)
		set_fractal(height_noise, FastNoiseLite.FRACTAL_FBM, 10, 0.4)
	else:
		set_noise(cavern_layout_noise, 0.01)
		set_noise(moisture_noise, 0.018)
		set_noise(depth_noise, 0.015)

		set_fractal(cavern_layout_noise,FastNoiseLite.FRACTAL_FBM, 5, 0.3)
		set_fractal(depth_noise,FastNoiseLite.FRACTAL_FBM, 10, 0.2)
		set_fractal(moisture_noise,FastNoiseLite.FRACTAL_FBM, 4, 0.3)

func set_noise(noise, frequency):
	noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	noise.set_seed(randi()%100000)
	noise.set_frequency(frequency)

func set_fractal(noise, type, octaves, weight):
	noise.set_fractal_type(type)
	noise.set_fractal_octaves(octaves)
	noise.set_fractal_weighted_strength(weight)

func scale_temperature(t):
	return ((t + 1) / 2) * 70 - 30

func temperature_modifier(x, height): 
	return sin((x / height) * 2 * PI - PI/2) * 20

func scale_precipitation(p):
	var prec = ((p + 1) / 2) * 400 - 100
	return prec if prec >= 0 else 0

func scale_height(h):
	return ((h + 1) / 2) * 8500 - 4000

func scale_moisture(p):
	return ((p + 1) / 2) * 80 - 40

func scale_depth(d):
	return ((d + 1) / 2) * 160 - 75
