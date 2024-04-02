class_name ObstacleSpawnManager
extends Node

## This node is responsible for spawning an obstacle scene in the game.
## It relies on a [SpawnTimeManager] to determine when to spawn the next obstacle.

## This property determines the scene to spawn and subscribe to.
## It expects a scene that extends [BaseObstacle].
@export var spawn_element : PackedScene
## This property determines the position to spawn the obstacle.
@export var spawn_position : Marker2D

## The spawn timer created on _ready. It is responsible for emitting signals to spawn and
## clean up obstacles.
var spawn_timer : SpawnTimeManager

# On ready, spawn the first obstacle
func _ready():
	_setup_spawn_timer()
	spawn_next_obstacle()

func _setup_spawn_timer() -> void:
	spawn_timer = SpawnTimeManager.new()
	spawn_timer.spawn_next.connect(spawn_next_obstacle)
	spawn_timer.clean_up.connect(_on_cleanup)
	add_child(spawn_timer)

## This function will spawn an obstacle, position it, and subscribe to it
## When the obstacle is fully spawned, it will spawn the next one.
## When the obstacle is passed, it will remove it.
func spawn_next_obstacle() -> void:
	var obstacle = _init_obstacle()
	_place_obstacle(obstacle)

# === Private functions ===

func _on_cleanup(obstacle: BaseObstacle) -> void:
	obstacle.queue_free()

func _init_obstacle() -> BaseObstacle:
	var obstacle = spawn_element.instantiate()
	assert(obstacle is BaseObstacle, "Spawned obstacle is not a BaseObstacle")

	spawn_timer.subscribe(obstacle)
	return obstacle

func _place_obstacle(obstacle: BaseObstacle) -> void:
	if(spawn_position):
		obstacle.global_position = spawn_position.global_position
	var level_root = Level.get_object_level(self)
	level_root.add_child.call_deferred(obstacle)
