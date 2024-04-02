extends GutTest

var manager : ObstacleSpawnManager

func before_each():
    manager = ObstacleSpawnManager.new()
    add_child_autofree(manager)

func test_something():
    assert_false(true, "Implement me!")