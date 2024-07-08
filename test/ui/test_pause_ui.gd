extends GutTest

var pause_ui : PauseUI

func before_each():
	pause_ui = PauseUI.new()
	pause_ui.popup = PopupPanel.new()
	pause_ui.quit_btn = Button.new()
	pause_ui.resume_btn = Button.new()

	pause_ui.add_child(pause_ui.popup)
	pause_ui.add_child(pause_ui.quit_btn)
	pause_ui.add_child(pause_ui.resume_btn)

	add_child_autofree(pause_ui)

func after_each():
	GameStateManager.reset_environment()

func _ready():
	# This test pauses the game, so we need to ensure that the test is not paused
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func test_popup_is_invisible_by_default():
	assert_false(pause_ui.popup.visible)

func test_pause_show_cannot_run_when_not_playing():
	GameStateManager.current_state = GameStateManagerCode.GameState.MAIN_MENU
	pause_ui.pause_show()
	assert_false(pause_ui.popup.visible)

func test_pause_show_pauses_game():
	GameStateManager.current_state = GameStateManagerCode.GameState.PLAYING
	pause_ui.pause_show()
	assert_true(pause_ui.popup.visible)
	assert_true(get_tree().paused)

func test_resume_button_unpauses_game():
	GameStateManager.current_state = GameStateManagerCode.GameState.PLAYING
	pause_ui.pause_show()

	pause_ui.resume_btn.pressed.emit()
	assert_false(pause_ui.popup.visible)
	assert_false(get_tree().paused)
