class_name MovingObstacle
extends BaseObstacle

## This class represents a moving obstacle that moves in a specified direction at a specified speed.
## You can extend this class to create more custom moving obstacles.

## The speed at which the obstacle moves
@export var speed : float = 100
## The direction in which the obstacle moves
@export var direction : Vector2 = Vector2.LEFT
## The Area2D that checks for screen start/end boundaries
@export var tail_area : Area2D

func _ready():
	super()
	assert(tail_area, "Must set a tail area")
	tail_area.area_entered.connect(_on_tail_enter)
	tail_area.area_exited.connect(_on_tail_exit)

func _physics_process(delta: float):
	_move_obstacle(delta)

## This function moves the obstacle in the direction specified by the `direction` variable.
## You can overwrite this function to add custom behavior to the obstacle's movement.
func _move_obstacle(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if !collision:
		return
	var obj = collision.get_collider()
	if obj is Player:
		(obj as Player).die(self)

func _on_tail_enter(area: Area2D) -> void:
	if area is LevelBoundary:
		# Tail has cleared the runway
		obstacle_spawned.emit()

func _on_tail_exit(area: Area2D) -> void:
	if area is LevelBoundary:
		# Tail has cleared the level/screen
		obstacle_passed.emit()
