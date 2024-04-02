extends GutTest

var manager : ObstacleSpawnManager

func before_each():
    manager = ObstacleSpawnManager.new()
    watch_signals(manager)

func after_each():
    if(manager):
        manager.queue_free()

func test_creates_spawn_time_manager():
    # 😔🤔
    assert_true(false, "Not implemented")
    pass

func test_spawns_an_object_on_spawn_signal():
    # 😔🤔
    assert_true(false, "Not implemented")
    pass

func test_removes_object_on_cleanup_signal():
    # 😔🤔
    assert_true(false, "Not implemented")
    pass