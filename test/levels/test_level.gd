extends GutTest

var level : Level

func before_each():
    level = Level.new()
    level.boundary = LevelBoundary.new()
    level.add_child(level.boundary)

func test_sets_self_as_active_level_on_ready():
    assert_null(GameStateManager.active_level)
    add_child_autofree(level)
    assert_eq(GameStateManager.active_level, level)

func test_starts_spawner_if_set():
    level.spawner = double(BaseObstacleSpawner).new()
    level.add_child(level.spawner)

    assert_not_called(level.spawner, "start")
    add_child_autofree(level)
    assert_called(level.spawner, "start")