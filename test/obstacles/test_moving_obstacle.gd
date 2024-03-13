extends GutTest

class BaseMoveObstacleTest:
	extends GutTest

	var obstacle : MovingObstacle

	func before_each():
		obstacle = MovingObstacle.new()
		var tail_area = Area2D.new()
		obstacle.add_child(tail_area)
		obstacle.tail_area = tail_area
		add_child_autofree(obstacle)

class TestTailSignals:
	extends BaseMoveObstacleTest

	func before_each():
		super()
		watch_signals(obstacle)

	func test_should_emit_spawned_on_enter_level_boundary():
		var boundary = add_child_autofree(LevelBoundary.new())

		obstacle.tail_area.area_entered.emit(boundary)
		assert_signal_emitted(obstacle, "obstacle_spawned")
	
	func test_should_not_emit_spawned_non_level_boundary():
		var non_boundary = add_child_autofree(Node.new())

		obstacle.tail_area.area_entered.emit(non_boundary)
		assert_signal_not_emitted(obstacle, "obstacle_spawned")
	
	func test_should_emit_passed_on_exit_level_boundary():
		var boundary = add_child_autofree(LevelBoundary.new())

		obstacle.tail_area.area_exited.emit(boundary)
		assert_signal_emitted(obstacle, "obstacle_passed")
	
	func test_should_not_emit_passed_non_level_boundary():
		var non_boundary = add_child_autofree(Node.new())

		obstacle.tail_area.area_exited.emit(non_boundary)
		assert_signal_not_emitted(obstacle, "obstacle_passed")

class TestMoving:
	extends BaseMoveObstacleTest

	func test_obstacle_should_move():
		var initial_position = obstacle.global_position
		obstacle._physics_process(1)
		assert_ne(obstacle.global_position, initial_position)

	var move_test_cases = [
		{
			"speed": 100,
			"direction": Vector2(1, 0),
			"expected_position": Vector2(100, 0)
		},
		{
			"speed": 50,
			"direction": Vector2(0, 1),
			"expected_position": Vector2(0, 50)
		},
		{
			"speed": 10,
			"direction": Vector2(-2, 0),
			"expected_position": Vector2(-20, 0)
		},
		{
			"speed": 20,
			"direction": Vector2(0, -5),
			"expected_position": Vector2(0, -100)
		}
	]

	func test_obstacle_should_move_at_speed( move_args=use_parameters(move_test_cases) ):
		obstacle.global_position = Vector2.ZERO
		obstacle.speed = move_args["speed"]
		obstacle.direction = move_args["direction"]

		obstacle._physics_process(1)

		var expected_position = move_args["expected_position"]
		assert_almost_eq(obstacle.global_position.x, expected_position.x, 0.1)
		assert_almost_eq(obstacle.global_position.y, expected_position.y, 0.1)
