class_name ScoreUI
extends BaseUI

## This class is responsible for rendering the score on the screen.

## The label that displays the score.
@export var label: Label

func _ready():
	assert(label, "Label must be set for ScoreUI")

## Set the score to be displayed. 
## This function will convert the score to a string and set the label's text to it.
## If the score is a large number, it will be displayed with commas.
func set_score(score: int) -> void:
	label.text = format_number_with_commas(score)
