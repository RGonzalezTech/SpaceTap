extends GutTest

var game_init : GameInit
var splash_manager : SplashScreenManager

var mock_splash_sceen = preload("res://scenes/__mocks__/MockSplashScreen.tscn")

func before_each():
    game_init = GameInit.new()
    watch_signals(game_init)

    splash_manager = SplashScreenManager.new()
    watch_signals(splash_manager)
    game_init.add_child(splash_manager)
    game_init.splash_manager = splash_manager

    game_init.main_menu = mock_splash_sceen.duplicate()

func after_each():
    Engine.time_scale = 1
    if(game_init != null):
        game_init.queue_free()

func test_calls_splash_on_ready_with_no_splash():
    assert_signal_not_emitted(splash_manager, "all_finished")
    assert_signal_not_emitted(game_init, "game_ready")

    add_child_autoqfree(game_init)

    assert_signal_emitted(splash_manager, "all_finished")
    assert_signal_emitted(game_init, "game_ready")

func test_calls_splash_on_ready_with_some_splash():
    Engine.time_scale = 5
    splash_manager.splash_screens = [
        mock_splash_sceen.duplicate(),
        mock_splash_sceen.duplicate(),
        mock_splash_sceen.duplicate()
    ]

    assert_signal_not_emitted(splash_manager, "all_finished")
    assert_signal_not_emitted(game_init, "game_ready")

    add_child_autoqfree(game_init)

    # MockSplashScreen is set to finish after 0.25 seconds
    assert_signal_not_emitted(splash_manager, "all_finished")
    assert_signal_not_emitted(game_init, "game_ready")
    assert_signal_not_emitted(splash_manager, "screen_finished")
    await game_init.game_ready

    assert_signal_emitted(splash_manager, "all_finished")
    assert_signal_emitted(game_init, "game_ready")
    assert_signal_emit_count(splash_manager, "screen_finished", 3)