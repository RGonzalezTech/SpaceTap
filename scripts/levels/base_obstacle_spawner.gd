class_name BaseObstacleSpawner
extends Node

## Base class for Obstacle Spawners.

## The ObstacleMonitor that will be used to detect when to 
## spawn new obstacles or remove old ones.
var obstacle_monitor : ObstacleMonitor

func _ready():
	_setup_obstacle_monitor()

func _setup_obstacle_monitor() -> void:
	obstacle_monitor = ObstacleMonitor.new()
	obstacle_monitor.spawn_next.connect(spawn_next_obstacle)
	obstacle_monitor.clean_up.connect(on_cleanup)
	add_child(obstacle_monitor)

## Called when the game starts.
func start() -> void:
	assert(false, "start must be implemented by the subclass")

## Called when the [ObstacleMonitor] emits the spawn_next signal.
## This method should be implemented by the subclass to spawn
## new obstacles.
func spawn_next_obstacle() -> void:
	assert(false, "spawn_next_obstacle must be implemented by the subclass")

## Called when the [ObstacleMonitor] emits the clean_up signal.
## This method queues the obstacle for removal by default.
func on_cleanup(obstacle: BaseObstacle) -> void:
	obstacle.queue_free()