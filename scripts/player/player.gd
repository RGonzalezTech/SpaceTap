class_name Player
extends RigidBody2D

@export var pause_ui : PauseUI

## This class represents the player's character. It is responsible for responding to 
## input events and checking for collisions with obstacles. 
## It also expects a [ScoreUI] node to render the score

## This signal is emitted when the player dies. It reports the obstacle that killed the player
## This can be used to display a game over screen or to play a sound effect.
signal died(obstacle: BaseObstacle)

## This variable represents the strength of the player's jump.
## When the player jumps, we set the y velocity to this value
@export var jump_strength : int = 600

## The [ScoreUI] node that is responsible for rendering the player's score
## This variable is not required, but it is recommended.
@export var score_ui : ScoreUI

## The [InputManager] node that is responsible for handling the player's input.
## This object is created on ready.
var input_manager : InputManager

## The [ScoreManager] node that is responsible for managing the player's score.
## This object is created on ready.
var score_manager : ScoreManager

## This function is called by the Obstacle when it collides with the player.
## It emits the "died" signal with the obstacle that was passed as an argument.
func die(obstacle: BaseObstacle) -> void:
	died.emit(obstacle)

## This function will pass the points to the [ScoreManager] to increase the score
func add_points(points: int) -> void:
	score_manager.increase_score(points)

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	assert(pause_ui, "Player: 'pause_ui' is required")
	
	_subscribe_to_inputs()
	_subscribe_to_score()

# Private methods
func _subscribe_to_inputs() -> void:
	# User Inputs
	input_manager = InputManager.new()
	input_manager.jumped.connect(_on_jumped)
	input_manager.cancel.connect(_on_cancel)
	add_child(input_manager)

func _subscribe_to_score() -> void:
	score_manager = ScoreManager.new()
	if(score_ui):
		score_manager.score_changed.connect(score_ui.set_score)
	add_child(score_manager)

# Listeners
# This function is called when the player's input manager emits the "jumped" signal.
# It sets the player's y velocity to the jump_strength
func _on_jumped() -> void:
	if(get_tree().paused):
		return

	# Negative y velocity to jump "up"
	self.linear_velocity.y = jump_strength * -1

# This function is called when the player's input manager emits the "cancel" signal.
# This typically means that they player is toggling the pause menu.
func _on_cancel() -> void:
	pause_ui.pause_show()
