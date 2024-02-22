class_name MovingObstacle
extends BaseObstacle

@export var speed : float = 100
@export var direction : Vector2 = Vector2.LEFT

func _physics_process(delta):
	_move_obstacle(delta)

func _move_obstacle(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if(collision and collision.get_collider().is_in_group("player")):
		# Touched the player with one of our colliders
		obstacle_failed.emit()
