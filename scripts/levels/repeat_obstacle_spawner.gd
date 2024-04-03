class_name RepeatObstacleSpawner
extends BaseObstacleSpawner

## This node is responsible for spawning an obstacle scene in the game.
## It relies on a [ObstacleMonitor] to determine when to spawn the next obstacle.

## This property determines the scene to spawn and subscribe to.
## It expects a scene that extends [BaseObstacle].
@export var spawn_element : PackedScene
## This property determines the position to spawn the obstacle.
@export var spawn_position : Marker2D

## Spawns the first obstacle and subscribes to it.
func start() -> void:
	spawn_next_obstacle()

## This function will spawn an obstacle, position it, and subscribe to it
## When the obstacle is fully spawned, it will spawn the next one.
## When the obstacle is passed, it will remove it.
func spawn_next_obstacle() -> void:
	var obstacle = _init_obstacle()
	_place_obstacle(obstacle)

# === Private functions ===

func _init_obstacle() -> BaseObstacle:
	var obstacle = spawn_element.instantiate()
	assert(obstacle is BaseObstacle, "Spawned obstacle is not a BaseObstacle")

	self.obstacle_monitor.subscribe(obstacle)
	return obstacle

func _place_obstacle(obstacle: BaseObstacle) -> void:
	if(spawn_position):
		obstacle.global_position = spawn_position.global_position
	var level_root = Level.get_object_level(self)
	level_root.add_child.call_deferred(obstacle)
