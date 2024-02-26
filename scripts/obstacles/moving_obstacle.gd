class_name MovingObstacle
extends BaseObstacle

## This class represents a moving obstacle that moves in a specified direction at a specified speed.
## You can extend this class to create more custom moving obstacles.

## The speed at which the obstacle moves
@export var speed : float = 100
## The direction in which the obstacle moves
@export var direction : Vector2 = Vector2.LEFT

func _physics_process(delta: float):
	_move_obstacle(delta)

## This function moves the obstacle in the direction specified by the `direction` variable.
## You can overwrite this function to add custom behavior to the obstacle's movement.
func _move_obstacle(delta: float) -> void:
	var _collision = move_and_collide(direction * speed * delta)
