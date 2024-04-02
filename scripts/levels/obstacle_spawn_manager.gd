class_name ObstacleSpawnManager
extends Node

## Spawns obstacles one after the other.

## This signal is emitted when an obstacle is spawned.
signal obstacle_spawned(obstacle : BaseObstacle)

## This property determines the scene to spawn and subscribe to.
## It expects a scene that extends BaseObstacle.
@export var spawn_element : PackedScene
## This property determines the position to spawn the obstacle.
@export var spawn_position : Marker2D

# On ready, spawn the first obstacle
func _ready():
	spawn_next_obstacle()

## This function will spawn an obstacle, position it, and subscribe to it
## When the obstacle is fully spawned, it will spawn the next one.
## When the obstacle is passed, it will remove it.
func spawn_next_obstacle() -> void:
	var obstacle = _init_obstacle()
	_subscribe_to_obstacle(obstacle)
	_place_obstacle(obstacle)

# === Private functions ===

func _init_obstacle() -> BaseObstacle:
	var obstacle = spawn_element.instantiate()
	assert(obstacle is BaseObstacle, "Spawned obstacle is not a BaseObstacle")
	return obstacle

func _subscribe_to_obstacle(obstacle: BaseObstacle) -> void:
	obstacle.obstacle_spawned.connect(_on_obstacle_spawned)
	obstacle.obstacle_passed.connect(_on_obstacle_passed.bind(obstacle))

func _place_obstacle(obstacle: BaseObstacle) -> void:
	if(spawn_position):
		obstacle.global_position = spawn_position.global_position
	var level_root = Level.get_object_level(self)
	level_root.add_child.call_deferred(obstacle)

func _on_obstacle_spawned() -> void:
	# Spawn the next one
	spawn_next_obstacle()

func _on_obstacle_passed(obstacle: BaseObstacle) -> void:
	# Remove it
	obstacle.queue_free()
