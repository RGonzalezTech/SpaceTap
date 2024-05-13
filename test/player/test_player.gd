extends GutTest

class BasePlayerTests:
	extends GutTest
	var player: Player
	
	var pause_ui : PauseUI

	func before_each():
		player = Player.new()
		
		# Prepare Pause UI
		pause_ui = PauseUI.new()
		pause_ui.popup = PopupPanel.new()
		pause_ui.quit_btn = Button.new()
		pause_ui.resume_btn = Button.new()
		
		pause_ui.add_child(pause_ui.popup)
		pause_ui.add_child(pause_ui.quit_btn)
		pause_ui.add_child(pause_ui.resume_btn)
		
		add_child_autofree(pause_ui)
		player.pause_ui = pause_ui
		
		watch_signals(player)

class TestScoreUI:
	extends BasePlayerTests

	var score_ui : ScoreUI
	var score_label : Label

	func before_each():
		super()
		# Prepare Score UI
		score_ui = ScoreUI.new()
		score_label = Label.new()
		score_ui.add_child(score_label)
		score_ui.label = score_label
		add_child_autofree(score_ui)

		player.score_ui = score_ui

		# Score Manager is created on ready
		add_child_autofree(player)

	func test_updates_score_ui_on_score_change():
		assert_ne(score_label.text, "100")
		player.add_points(100)
		assert_eq(score_label.text, "100")
		player.add_points(100)
		assert_eq(score_label.text, "200")

class TestPhysics:
	extends BasePlayerTests

	func before_each():
		super()
		add_child_autofree(player)

	var jump_strength_tests = [10, 20, 50, 200]
	func test_jump_strength(strength=use_parameters(jump_strength_tests)):
		# Not moving
		assert_eq(player.linear_velocity.y, 0.00)

		# Jump
		player.jump_strength = strength

		# Jump should not multiply strength
		for i in range(3):
			player.input_manager.jumped.emit()
			
		# Check velocity (-Y = UP)
		assert_eq(player.linear_velocity.y, strength * - 1.00)

	func test_emits_died_on_touching_obstacle():
		var obstacle = BaseObstacle.new()
		add_child_autofree(obstacle)

		assert_signal_not_emitted(player, "died")
		player.die(obstacle)
		assert_signal_emitted(player, "died")

	func test_does_not_emit_died_on_touching_other():
		var other = CharacterBody2D.new()
		add_child_autofree(other)

		assert_signal_not_emitted(player, "died")
		player.body_entered.emit(other)
		assert_signal_not_emitted(player, "died")
