class_name ScoreUI
extends Node

@export var label : Label

func _ready():
	assert(label, "Label must be set for ScoreUI")

func set_score(points: int) -> void:
	label.text = str(points)
