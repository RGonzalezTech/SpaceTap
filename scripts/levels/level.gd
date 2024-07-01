class_name Level
extends Node2D

## This node represents a level in the game.

## The level boundary, which is used by obstacles to determine if they are out of bounds
@export var boundary : LevelBoundary

## The obstacle spawner, which is used to spawn obstacles for this level
@export var spawner : BaseObstacleSpawner

func _ready():
	assert(boundary, "LevelBoundary not found")
	GameStateManager.reset_environment()
	GameStateManager.active_level = self
	GameStateManager.current_state = GameStateManagerCode.GameState.PLAYING

	if(spawner):
		spawner.start()
	else:
		print("Level: No spawner found")
