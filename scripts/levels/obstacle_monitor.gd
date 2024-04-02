class_name ObstacleMonitor
extends Node

## This node is responsible for listening to obstacles and emitting a signal
## when it's time to spawn the next obstacle.

## This signal is emitted when it's time to spawn the next obstacle.
## This will happen when an obstacle emits the obstacle_spawned signal.
## That signal means that the obstacle has cleared enough space for the next one.
signal spawn_next
## This signal is emitted when an obstacle has cleared the screen.
## This will happen when an obstacle emits the obstacle_passed signal.
signal clean_up(obstacle: BaseObstacle)

## This function subscribes to an obstacle's signals.
func subscribe(obstacle: BaseObstacle) -> void:
	obstacle.obstacle_spawned.connect(_on_obstacle_spawned, CONNECT_ONE_SHOT)
	obstacle.obstacle_passed.connect(_on_obstacle_passed.bind(obstacle), CONNECT_ONE_SHOT)

func _on_obstacle_spawned() -> void:
	# Spawn the next one
	spawn_next.emit()

func _on_obstacle_passed(obstacle: BaseObstacle) -> void:
	clean_up.emit(obstacle)