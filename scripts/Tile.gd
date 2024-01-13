extends Area2D

var type: Enums.TerrainTypes
var elevation: Enums.TerrainElevation
var average_temperature : float
var average_precipitation
var height

func set_height():
	if (height <= -750):
		elevation = Enums.TerrainElevation.DEEP_OCEAN
	elif (height > -750 and height <= -250):
		elevation = Enums.TerrainElevation.CLOSE_OCEAN
	elif (height > -250 and height <= 0):
		elevation = Enums.TerrainElevation.SHALLOW_WATER
	elif (height > 0 and height <= 500):
		elevation = Enums.TerrainElevation.PLAIN
	elif (height > 500 and height <= 1000):
		elevation = Enums.TerrainElevation.HILL
	elif (height > 1000):
		elevation = Enums.TerrainElevation.MOUNTAIN

func set_type():
	if (height <= 25):
		if (average_temperature <= -10 and height < 0):
			type = Enums.TerrainTypes.ICE
		else:
			match elevation:
				Enums.TerrainElevation.DEEP_OCEAN:
					type = Enums.TerrainTypes.DEEP_OCEAN
				Enums.TerrainElevation.CLOSE_OCEAN:
					type = Enums.TerrainTypes.CLOSE_OCEAN
				Enums.TerrainElevation.SHALLOW_WATER:
					type = Enums.TerrainTypes.SHALLOW_WATER
				_:
					type = Enums.TerrainTypes.BEACH
	else:
		if (average_temperature <= -5):
			if (average_precipitation <= 50):
				type = Enums.TerrainTypes.TUNDRA
			elif (average_precipitation > 50 and average_precipitation <= 175):
				type = Enums.TerrainTypes.BOREAL_FOREST
			else:
				type = Enums.TerrainTypes.SNOWPLAINS
		elif (average_temperature > -5 and average_temperature <= 20):
			if (average_precipitation <= 100):
				type = Enums.TerrainTypes.PRAIRIE
			elif (average_precipitation > 100 and average_precipitation <= 150):
				type = Enums.TerrainTypes.TEMPERATE_FOREST
			else:
				type = Enums.TerrainTypes.SWAMP
		else:
			if (average_precipitation <= 75):
				type = Enums.TerrainTypes.DESERT
			elif (average_precipitation > 75 and average_precipitation <= 150):
				type = Enums.TerrainTypes.SAVANNAH
			else:
				type = Enums.TerrainTypes.TROPICAL_RAINFOREST

func  recolor():
	match type:
		Enums.TerrainTypes.TUNDRA:
			modulate = Color("c7714a")
		Enums.TerrainTypes.BOREAL_FOREST:
			modulate = Color("04572f")
		Enums.TerrainTypes.SNOWPLAINS:
			modulate = Color("d4d4d4")
		Enums.TerrainTypes.PRAIRIE:
			modulate = Color("66bf2a")
		Enums.TerrainTypes.TEMPERATE_FOREST:
			modulate = Color("117811")
		Enums.TerrainTypes.SWAMP:
			modulate = Color("1d420b")
		Enums.TerrainTypes.DESERT:
			modulate = Color("a38524")
		Enums.TerrainTypes.SAVANNAH:
			modulate = Color("9c9e05")
		Enums.TerrainTypes.TROPICAL_RAINFOREST:
			modulate = Color("065c03")
		Enums.TerrainTypes.DEEP_OCEAN:
			modulate = Color("1d1db3")
		Enums.TerrainTypes.CLOSE_OCEAN:
			modulate = Color("2a4da3")
		Enums.TerrainTypes.SHALLOW_WATER:
			modulate = Color("4490db")
		Enums.TerrainTypes.ICE:
			modulate = Color("77b5ba")
		Enums.TerrainTypes.BEACH:
			modulate = Color("c4b068")
		_:
			modulate = Color("000000")
