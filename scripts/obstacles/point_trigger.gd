class_name PointTrigger
extends Area2D

## This class is used to create an area that the player can claim by walking through it.

## This signal is emitted when the value is claimed.
signal claimed

## This value will be given to the player when they claim the trigger.
@export var value : int = 1

var _claimed = false

## If the trigger has been claimed before, it returns 0. Otherwise, it returns the value of the trigger.
func claim() -> int:
	if not _claimed:
		_claimed = true
		claimed.emit()
		return value
	return 0

## This function can be called to check if the trigger has been claimed.
func is_claimed() -> bool:
	return _claimed

func _ready():
	body_exited.connect(_on_body_exit)

func _on_body_exit(body: Node) -> void:
	# Only players can claim the trigger
	if not body is Player:
		return

	# Increase their score (if it has not been claimed already)
	var claimed_points = claim()
	(body as Player).add_points(claimed_points)
