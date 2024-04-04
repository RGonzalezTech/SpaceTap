class_name RepeatVerticalScatterSpawner
extends RepeatObstacleSpawner

## This spawner will spawn things at a set [Marker2D], then move up or down by a set amount.

## The distance to scatter the obstacles up or down.
@export var scatter_distance: float = 500

func _place_obstacle(obstacle: BaseObstacle) -> void:
    if(spawn_position):
        obstacle.position = spawn_position.position
    obstacle.position.y += scatter_distance * (randf() - 0.5)
    place_in_level(obstacle)
