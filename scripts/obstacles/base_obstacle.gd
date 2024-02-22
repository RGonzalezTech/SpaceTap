class_name BaseObstacle
extends CharacterBody2D

## This is the base class for all obstacles in the game. It contains the signals and variables that all obstacles will need to use.

## When the player has successfully completed this obstacle. It returns the value of the obstacle.
signal obstacle_passed(points)
## When the player has failed to complete this obstacle
signal obstacle_failed
## When the player has made partial progress through this obstacle (e.g. 50%, 75%)
signal obstacle_progress(progress_percent)
## When the obstacle has been spawned and has moved sufficiently into the screen to be visible and allow room for another obstacle to be spawned
signal obstacle_spawn_complete

## The value of this obstacle when passed
@export var points : int = 1
## Obstacle scenes that can be spawned after this one (to keep the randomization interesting and fair)
@export var following_obstacles : Array[BaseObstacle] = []

## Whether this obstacle contains any following obstacles
func has_following_obstacles() -> bool:
	return following_obstacles.size() > 0
