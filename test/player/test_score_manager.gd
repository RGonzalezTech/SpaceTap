extends GutTest

var manager : ScoreManager

func before_each():
	manager = ScoreManager.new()
	watch_signals(manager)
	add_child_autofree(manager)

func test_adding_score_increases_total_score():
	assert_eq(manager.get_score(), 0)
	manager.increase_score(10)
	assert_eq(manager.get_score(), 10)

func test_adding_score_emits_signal():
	assert_signal_not_emitted(manager, "score_changed")
	manager.increase_score(10)
	assert_signal_emitted_with_parameters(manager, "score_changed", [10])
	manager.increase_score(10)
	assert_signal_emitted_with_parameters(manager, "score_changed", [20])
	assert_eq(manager.get_score(), 20)

func test_increasing_by_zero_does_not_emit():
	assert_signal_not_emitted(manager, "score_changed")
	manager.increase_score(0)
	assert_signal_not_emitted(manager, "score_changed")
	assert_eq(manager.get_score(), 0)

func test_increase_by_negative_does_not_emit():
	assert_signal_not_emitted(manager, "score_changed")
	manager.increase_score(-10)
	assert_signal_not_emitted(manager, "score_changed")
	assert_eq(manager.get_score(), 0)
