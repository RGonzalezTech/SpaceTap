class_name BaseObstacle
extends CharacterBody2D

signal obstacle_passed(points)
signal obstacle_failed
signal obstacle_progress(progress_percent)
signal obstacle_spawn_complete

@export var points : int = 1
@export var following_obstacles : Array[BaseObstacle] = []

func has_following_obstacles() -> bool:
	return following_obstacles.size() > 0
