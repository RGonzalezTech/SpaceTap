class_name PointTrigger
extends Area2D

## This class is used to create a trigger that the player can claim by walking into it.

signal claimed

@export var points : int = 1

var _claimed = false

## This function can be called on the trigger to claim it. 
## If the trigger has not been claimed, it will return the points and set the trigger as claimed.
func claim() -> int:
	if not _claimed:
		_claimed = true
		claimed.emit()
		return points
	return 0

## This function can be called to check if the trigger has been claimed.
func is_claimed() -> bool:
	return _claimed

func _ready():
	body_exited.connect(_on_body_exit)

func _on_body_exit(body: Node) -> void:
	if not body is Player:
		return

	var earned_points = claim()
	if earned_points > 0:
		(body as Player).add_points(earned_points)
