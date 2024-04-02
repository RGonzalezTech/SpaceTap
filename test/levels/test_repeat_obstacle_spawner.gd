extends GutTest

var manager : RepeatObstacleSpawner

func before_each():
	manager = RepeatObstacleSpawner.new()
	manager.spawn_element = PackedScene.new()
	manager.spawn_position = Marker2D.new()
	manager.spawn_position.global_position = Vector2(50, 50)
	watch_signals(manager)
	# add_child_autofree(manager)

func test_spawns_an_object_on_spawn_signal():
	# 😔🤔
	assert_true(false, "Not implemented")
	pass

func test_removes_object_on_cleanup_signal():
	# 😔🤔
	assert_true(false, "Not implemented")
	pass
