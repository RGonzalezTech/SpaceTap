class_name GameOverUI
extends BaseUI

## The panel that is hidden by default and shown when the player dies
@export var panel : Control

## The label to display the name of the obstacle that triggered
## the game over screen
@export var obstacle_name_label : Label

## The label to display the player's score at the time of 
## the game over screen
@export var score_label : Label

## The button to quit the game in this UI
@export var quit_btn : Button
## The button to restart the game in this UI
@export var restart_btn : Button


func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	_assert_required_nodes()

	quit_btn.pressed.connect(_on_quit)
	restart_btn.pressed.connect(_on_restart)

func _assert_required_nodes():
	assert(panel, "[GameOverUI]: panel is required")
	assert(panel.visible == false, "[GameOverUI]: panel should be hidden by default")
	assert(obstacle_name_label, "[GameOverUI]: obstacle_name_label is required")
	assert(score_label, "[GameOverUI]: score_label is required")
	assert(quit_btn, "[GameOverUI]: quit_btn is required")
	assert(restart_btn, "[GameOverUI]: restart_btn is required")

func _on_quit():
	GameStateManager.go_main_menu()

func _on_restart():
	# Restart the current level
	GameStateManager.restart_level()

## This function is called by the `player.die()` function
## it's purpose is to pause the game and show the game over screen
func show_game_over(obstacle: BaseObstacle, score: int) -> void:
	# No longer playing a level
	GameStateManager.current_state = GameStateManagerCode.GameState.GAME_OVER
	# Pause the game
	get_tree().paused = true
	# name the obstacle that killed the player
	obstacle_name_label.text = obstacle.obstacle_name
	# show the score
	score_label.text = str(score)
	# show the game over screen
	panel.visible = true;
