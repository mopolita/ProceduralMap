extends Node2D

@export var tile_map:  TileMap

var grid_size = Vector2(300, 200)
var tile_grid: Array
var world_type: Enums.WorldType

func _ready():
	generate_map(world_type)

func generate_map(type):
	Perlin.setup(type)
	tile_grid = []
	for col in range(grid_size.y):
		var row_array = []
		for row in range(grid_size.x):
			var tile_value = Perlin.generate_tile(type, row, col, grid_size.y)
			if (type == Enums.WorldType.OVERWORLD):
				tile_value.append(get_overworld_elevation(tile_value[2]))
				tile_value.append(get_overworld_type(tile_value[0], tile_value[1], tile_value[2], tile_value[3]))
				set_overworld_tile(row - (grid_size.x / 2), col  - (grid_size.y / 2), tile_value[4])
			else:
				tile_value.append(get_undeworld_type(tile_value[0], tile_value[1], tile_value[2]))
				set_underworld_tile(row - (grid_size.x / 2), col  - (grid_size.y / 2), tile_value[3])
			row_array.append(tile_value)
		tile_grid.append(row_array)

func get_overworld_elevation(height):
	var elevation
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
	else:
		elevation = Enums.TerrainElevation.MOUNTAIN
	return elevation

func get_overworld_type(temperature, precipitation, height, elevation):
	var type
	if (height <= 0):
		if (temperature <= -10):
			type = Enums.OverworldTerrainTypes.ICE
		else:
			match elevation:
				Enums.TerrainElevation.DEEP_OCEAN:
					type = Enums.OverworldTerrainTypes.DEEP_OCEAN
				Enums.TerrainElevation.CLOSE_OCEAN:
					type = Enums.OverworldTerrainTypes.CLOSE_OCEAN
				_:
					type = Enums.OverworldTerrainTypes.SHALLOW_WATER
	else:
		if (temperature <= -5):
			if (precipitation <= 50):
				type = Enums.OverworldTerrainTypes.TUNDRA
			elif (precipitation > 50 and precipitation <= 175):
				type = Enums.OverworldTerrainTypes.BOREAL_FOREST
			else:
				type = Enums.OverworldTerrainTypes.SNOWPLAINS
		elif (temperature > -5 and temperature <= 20):
			if (precipitation <= 90):
				type = Enums.OverworldTerrainTypes.PRAIRIE
			elif (precipitation > 90 and precipitation <= 150):
				type = Enums.OverworldTerrainTypes.TEMPERATE_FOREST
			else:
				type = Enums.OverworldTerrainTypes.SWAMP
		else:
			if (precipitation <= 75):
				type = Enums.OverworldTerrainTypes.DESERT
			elif (precipitation > 75 and precipitation <= 150):
				type = Enums.OverworldTerrainTypes.SAVANNAH
			else:
				type = Enums.OverworldTerrainTypes.TROPICAL_RAINFOREST
	return type

func set_beach():
	pass

func set_overworld_tile(x: int, y: int, type: Enums.OverworldTerrainTypes):
	match type:
		Enums.OverworldTerrainTypes.TUNDRA:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))
		Enums.OverworldTerrainTypes.BOREAL_FOREST:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 1))
		Enums.OverworldTerrainTypes.SNOWPLAINS:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(1, 0))
		Enums.OverworldTerrainTypes.PRAIRIE:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(1, 1))
		Enums.OverworldTerrainTypes.TEMPERATE_FOREST:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(2, 0))
		Enums.OverworldTerrainTypes.SWAMP:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(2, 1))
		Enums.OverworldTerrainTypes.DESERT:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 0))
		Enums.OverworldTerrainTypes.SAVANNAH:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 1))
		Enums.OverworldTerrainTypes.TROPICAL_RAINFOREST:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(4, 0))
		Enums.OverworldTerrainTypes.BEACH:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(4, 1))
		Enums.OverworldTerrainTypes.ICE:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(5, 0))
		Enums.OverworldTerrainTypes.SHALLOW_WATER:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(5, 1))
		Enums.OverworldTerrainTypes.CLOSE_OCEAN:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(6, 0))
		Enums.OverworldTerrainTypes.DEEP_OCEAN:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(6, 1))
		_:
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))

func get_undeworld_type(cavern_layout, moisture, depth):
	var type
	if (depth <= 0):
		if (depth <= -15):
			type = Enums.UnderworldTerrainTypes.DEEP_LAVA
		else:
			type = Enums.UnderworldTerrainTypes.SHALLOW_LAVA	
	elif (cavern_layout <= 0):
		type = Enums.UnderworldTerrainTypes.CAVERN_WALL

	elif (moisture >= 0):
		type = Enums.UnderworldTerrainTypes.SHROOM
	else:
		type = Enums.UnderworldTerrainTypes.BARREN_LAND
	return type

func set_underworld_tile(x: int, y: int, type: Enums.UnderworldTerrainTypes):
	match type:
		Enums.UnderworldTerrainTypes.SHALLOW_LAVA:
			tile_map.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 0))
		Enums.UnderworldTerrainTypes.DEEP_LAVA:
			tile_map.set_cell(0, Vector2i(x, y), 1, Vector2i(1, 0))
		Enums.UnderworldTerrainTypes.SHROOM:
			tile_map.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 1))
		Enums.UnderworldTerrainTypes.CAVERN_WALL:
			tile_map.set_cell(0, Vector2i(x, y), 1, Vector2i(2, 0))
		Enums.UnderworldTerrainTypes.BARREN_LAND:
			tile_map.set_cell(0, Vector2i(x, y), 1, Vector2i(1, 1))
