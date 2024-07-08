extends GutTest

func _ready():
    # This test pauses the game, so we need to ensure that the test is not paused
    self.process_mode = Node.PROCESS_MODE_ALWAYS

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

func test_reset_environment_will_revert_changes_to_state_and_pause():
    manager.current_state = GameStateManagerCode.GameState.GAME_OVER
    manager.active_level = level
    Engine.time_scale = 0.5
    get_tree().paused = true

    manager.reset_environment()

    assert_eq(manager.current_state, GameStateManagerCode.GameState.MAIN_MENU)
    assert_null(manager.active_level)
    assert_eq(Engine.time_scale, 1.0)
    assert_false(get_tree().paused)