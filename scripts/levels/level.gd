class_name Level
extends Node2D

## This node represents a level in the game.

## The level boundary, which is used by obstacles to determine if they are out of bounds
@export var boundary : LevelBoundary

## The obstacle spawner, which is used to spawn obstacles for this level
@export var spawner : BaseObstacleSpawner

## This is a helper function to get the Level node from the game object
## It assumes that the level node is the second child of the root node
## If it is not, it will throw an error (failed assert)
static func get_object_level(game_obj: Node) -> Level:
	var level_node = game_obj.get_tree().root.get_child(1)
	assert(level_node is Level, "Level not found")
	return level_node

func _ready():
	assert(boundary, "LevelBoundary not found")
	assert(spawner, "Obstacle Spawner not found")

	if(spawner):
		spawner.start()
