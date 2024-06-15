extends GutTest

var manager : GameStateManagerCode
var level : Level

func before_each():
    manager = GameStateManagerCode.new()
    add_child_autofree(manager)

    level = Level.new()
    level.boundary = LevelBoundary.new()
    level.add_child(level.boundary)
    add_child_autofree(level)

func test_is_level_active_when_no_levels():
    assert_false(manager.is_level_active())

func test_is_level_active_when_a_level():
    manager.active_level = level

    assert_true(manager.is_level_active())