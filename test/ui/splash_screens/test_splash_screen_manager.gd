extends GutTest

var manager : SplashScreenManager
var mock_splash_sceen = preload("res://scenes/__mocks__/MockSplashScreen.tscn")

func before_each():
	manager = SplashScreenManager.new()
	watch_signals(manager)
	add_child_autoqfree(manager)

func after_each():
	Engine.time_scale = 1

func test_emits_signal_immediately_without_scenes():
	assert_signal_not_emitted(manager, "all_finished")
	assert_signal_not_emitted(manager, "screen_finished")

	manager.display_all_splash()

	assert_signal_emitted(manager, "all_finished")
	assert_signal_not_emitted(manager, "screen_finished")

var splash_counts : Array[int] = [2,5,10]
func test_emits_screen_finished_per_screen(splash_count=use_parameters(splash_counts)):
	# The mock splash screen has a wait time to make it more "realistic"
	# This will make the test run faster than real-time. Don't forget to set
	# The time_scale back to 1 (done in the after_each() func)
	Engine.time_scale = 5
	
	manager.splash_screens = []
	# Add dynaminc amounts of PackedScene to splash_screen var
	for i in range(splash_count):
		manager.splash_screens.push_back(mock_splash_sceen.duplicate())
	pass
	
	assert_signal_not_emitted(manager, "all_finished")
	assert_signal_not_emitted(manager, "screen_finished")
	
	manager.display_all_splash()
	await manager.all_finished
	
	assert_signal_emit_count(manager, "all_finished", 1)
	assert_signal_emit_count(manager, "screen_finished", splash_count)
