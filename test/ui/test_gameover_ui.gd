extends GutTest

var gameover_ui : GameOverUI

func _ready():
	# This test pauses the game, so we need to ensure that the test is not paused
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func before_each():
	GameStateManager.reset_environment()

	gameover_ui = GameOverUI.new()
	gameover_ui.panel = Control.new()
	gameover_ui.obstacle_name_label = Label.new()
	gameover_ui.score_label = Label.new()
	gameover_ui.quit_btn = Button.new()
	gameover_ui.restart_btn = Button.new()

	gameover_ui.panel.visible = false
	gameover_ui.add_child(gameover_ui.panel)
	gameover_ui.add_child(gameover_ui.obstacle_name_label)
	gameover_ui.add_child(gameover_ui.score_label)
	gameover_ui.add_child(gameover_ui.quit_btn)
	gameover_ui.add_child(gameover_ui.restart_btn)

	add_child_autofree(gameover_ui)

func after_each():
	GameStateManager.reset_environment()

func test_show_sets_state():
	assert_eq(GameStateManager.current_state, GameStateManagerCode.GameState.MAIN_MENU)
	assert_false(get_tree().paused)
	assert_false(gameover_ui.panel.visible)

	var obstacle = BaseObstacle.new()
	obstacle.obstacle_name = "This Test Obstacle"
	add_child_autofree(obstacle)
	gameover_ui.show_game_over(obstacle, 999)

	assert_eq(GameStateManager.current_state, GameStateManagerCode.GameState.GAME_OVER)
	assert_true(get_tree().paused)
	assert_true(gameover_ui.panel.visible)

	assert_eq(gameover_ui.obstacle_name_label.text, "This Test Obstacle")
	assert_eq(gameover_ui.score_label.text, "999")
