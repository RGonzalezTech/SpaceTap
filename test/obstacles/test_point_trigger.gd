extends GutTest

class BasePointTriggerTest:
	extends GutTest

	var point_trigger : PointTrigger

	func before_each():
		point_trigger = PointTrigger.new()
		point_trigger.value = 5
		add_child_autofree(point_trigger)

class TestTriggerClaim:
	extends BasePointTriggerTest

	func before_each():
		super()
		watch_signals(point_trigger)
	
	func test_claimed_only_emits_once():
		assert_signal_emit_count(point_trigger, "claimed", 0)
		point_trigger.claim()
		assert_signal_emit_count(point_trigger, "claimed", 1)
		point_trigger.claim()
		assert_signal_emit_count(point_trigger, "claimed", 1)
	
	func test_claim_returns_value_once():
		var value = point_trigger.claim()
		assert_eq(value, 5)
		value = point_trigger.claim()
		assert_eq(value, 0)
		value = point_trigger.claim()
		assert_eq(value, 0)
	
	func test_is_claimed_returns_true_after_claim():
		assert_false(point_trigger.is_claimed())
		assert_eq(point_trigger.claim(), 5)
		assert_true(point_trigger.is_claimed())
		assert_eq(point_trigger.claim(), 0)
		assert_true(point_trigger.is_claimed())

class TestPlayerArea:
	extends BasePointTriggerTest

	var player : Player
	
	func before_each():
		super()
		var mock_player_scene = preload("res://scenes/__mocks__/MockPlayer.tscn")
		player = mock_player_scene.instantiate()
		add_child_autofree(player)

	func test_player_exit_adds_points():
		assert_eq(player.score_manager.get_score(), 0)
		point_trigger.body_exited.emit(player)
		assert_eq(player.score_manager.get_score(), 5)
		point_trigger.body_exited.emit(player)
		assert_eq(player.score_manager.get_score(), 5)
	
	func test_claims_for_player():
		assert_false(point_trigger.is_claimed())
		point_trigger.body_exited.emit(player)
		assert_true(point_trigger.is_claimed())
		
	func test_does_not_claim_for_non_player():
		assert_false(point_trigger.is_claimed())
		var other = Node.new()
		add_child_autofree(other)
		point_trigger.body_exited.emit(other)
		assert_false(point_trigger.is_claimed())
