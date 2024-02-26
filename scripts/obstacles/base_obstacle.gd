class_name BaseObstacle
extends CharacterBody2D

## This is the base class for all obstacles in the game. It contains the signals and variables that all obstacles will need to use.

## When the player has successfully completed this obstacle. It can be removed from the scene after this signal is emitted.
signal obstacle_passed
## When the obstacle has been spawned and has moved sufficiently into the screen to be visible and allow room for another obstacle to be spawned
signal obstacle_spawned

## The name of this obstacle. Useful for debugging and UI purposes.
@export var obstacle_name : String = "BaseObstacle"
## The value of this obstacle when passed
@export var points : int = 1
## Obstacle scenes that can be spawned after this one (to keep the randomization interesting and fair)
@export var following_obstacles : Array[PackedScene] = []

## Whether this obstacle contains any following obstacles
func has_following_obstacles() -> bool:
	return following_obstacles.size() > 0
