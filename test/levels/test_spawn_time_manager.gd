extends GutTest

var manager : SpawnTimeManager
var obstacle : BaseObstacle

func before_each():
	manager = SpawnTimeManager.new()
	watch_signals(manager)
	add_child_autofree(manager)

	obstacle = BaseObstacle.new()
	add_child_autofree(obstacle)
	manager.subscribe(obstacle)

func test_emits_spawn_next_on_obstacle_spawn():
	assert_signal_not_emitted(manager, "spawn_next")
	obstacle.obstacle_spawned.emit()
	assert_signal_emitted(manager, "spawn_next")

func test_emits_cleanup_on_obstacle_passed():
	assert_signal_not_emitted(manager, "clean_up")
	obstacle.obstacle_passed.emit()
	assert_signal_emitted_with_parameters(manager, "clean_up", [obstacle])
