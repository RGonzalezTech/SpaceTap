extends GutTest

var screen : SplashScreen

func before_each():
    screen = SplashScreen.new()
    watch_signals(screen)
    add_child_autofree(screen)

func test_finish_emits_finished():
    assert_signal_not_emitted(screen, "finished")
    screen.finish()
    assert_signal_emitted(screen, "finished")