class_name ScoreManager
extends Node

## This class is responsible for managing a player's score.

# The current score. This value should only go up from 0.
var _score: int = 0

## When the score changes, this signal is emitted.
signal score_changed(score: int)

func get_score() -> int:
    return _score

## Increases the score by the given amount.
## It ignores values less than or equal to 0.
func increase_score(amount: int) -> void:
    if(amount <= 0):
        return

    _score += amount
    score_changed.emit(_score)