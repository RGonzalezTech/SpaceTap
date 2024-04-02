extends GutTest

var monitor : ObstacleMonitor
var obstacle : BaseObstacle

func before_each():
	monitor = ObstacleMonitor.new()
	watch_signals(monitor)
	add_child_autofree(monitor)

	obstacle = BaseObstacle.new()
	add_child_autofree(obstacle)
	monitor.subscribe(obstacle)

func test_emits_spawn_next_on_obstacle_spawn():
	assert_signal_not_emitted(monitor, "spawn_next")
	obstacle.obstacle_spawned.emit()
	assert_signal_emitted(monitor, "spawn_next")

func test_emits_cleanup_on_obstacle_passed():
	assert_signal_not_emitted(monitor, "clean_up")
	obstacle.obstacle_passed.emit()
	assert_signal_emitted_with_parameters(monitor, "clean_up", [obstacle])
