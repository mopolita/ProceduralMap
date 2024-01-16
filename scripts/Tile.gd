extends Area2D

@export var canvas: CanvasLayer
@export var hills: Texture2D
@export var mountains: Texture2D

var type: Enums.OverworldTerrainTypes
var elevation: Enums.TerrainElevation
var average_temperature : float
var average_precipitation
var height

func set_height():
	if (height <= -700):
		elevation = Enums.TerrainElevation.DEEP_OCEAN
	elif (height > -700 and height <= -200):
		elevation = Enums.TerrainElevation.CLOSE_OCEAN
	elif (height > -200 and height <= 0):
		elevation = Enums.TerrainElevation.SHALLOW_WATER
	elif (height > 0 and height <= 400):
		elevation = Enums.TerrainElevation.PLAIN
	elif (height > 400 and height <= 800):
		elevation = Enums.TerrainElevation.HILL
		hills.draw(canvas, Vector2.ZERO)
	elif (height > 1000):
		elevation = Enums.TerrainElevation.MOUNTAIN
		mountains.draw(canvas, Vector2.ZERO)

func set_type():
	if (height <= 20):
		if (average_temperature <= -10 and height < 0):
			type = Enums.OverworldTerrainTypes.ICE
		else:
			match elevation:
				Enums.TerrainElevation.DEEP_OCEAN:
					type = Enums.OverworldTerrainTypes.DEEP_OCEAN
				Enums.TerrainElevation.CLOSE_OCEAN:
					type = Enums.OverworldTerrainTypes.CLOSE_OCEAN
				Enums.TerrainElevation.SHALLOW_WATER:
					type = Enums.OverworldTerrainTypes.SHALLOW_WATER
				_:
					type = Enums.OverworldTerrainTypes.BEACH
	else:
		if (average_temperature <= -5):
			if (average_precipitation <= 50):
				type = Enums.OverworldTerrainTypes.TUNDRA
			elif (average_precipitation > 50 and average_precipitation <= 175):
				type = Enums.OverworldTerrainTypes.BOREAL_FOREST
			else:
				type = Enums.OverworldTerrainTypes.SNOWPLAINS
		elif (average_temperature > -5 and average_temperature <= 20):
			if (average_precipitation <= 100):
				type = Enums.OverworldTerrainTypes.PRAIRIE
			elif (average_precipitation > 100 and average_precipitation <= 150):
				type = Enums.OverworldTerrainTypes.TEMPERATE_FOREST
			else:
				type = Enums.OverworldTerrainTypes.SWAMP
		else:
			if (average_precipitation <= 75):
				type = Enums.OverworldTerrainTypes.DESERT
			elif (average_precipitation > 75 and average_precipitation <= 150):
				type = Enums.OverworldTerrainTypes.SAVANNAH
			else:
				type = Enums.OverworldTerrainTypes.TROPICAL_RAINFOREST

func  recolor():
	match type:
		Enums.OverworldTerrainTypes.TUNDRA:
			modulate = Color("c7714a")
		Enums.OverworldTerrainTypes.BOREAL_FOREST:
			modulate = Color("04572f")
		Enums.OverworldTerrainTypes.SNOWPLAINS:
			modulate = Color("d4d4d4")
		Enums.OverworldTerrainTypes.PRAIRIE:
			modulate = Color("66bf2a")
		Enums.OverworldTerrainTypes.TEMPERATE_FOREST:
			modulate = Color("117811")
		Enums.OverworldTerrainTypes.SWAMP:
			modulate = Color("1d420b")
		Enums.OverworldTerrainTypes.DESERT:
			modulate = Color("a38524")
		Enums.OverworldTerrainTypes.SAVANNAH:
			modulate = Color("9c9e05")
		Enums.OverworldTerrainTypes.TROPICAL_RAINFOREST:
			modulate = Color("065c03")
		Enums.OverworldTerrainTypes.DEEP_OCEAN:
			modulate = Color("1d1db3")
		Enums.OverworldTerrainTypes.CLOSE_OCEAN:
			modulate = Color("2a4da3")
		Enums.OverworldTerrainTypes.SHALLOW_WATER:
			modulate = Color("4490db")
		Enums.OverworldTerrainTypes.ICE:
			modulate = Color("77b5ba")
		Enums.OverworldTerrainTypes.BEACH:
			modulate = Color("c4b068")
		_:
			modulate = Color("000000")
