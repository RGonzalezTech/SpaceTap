class_name SplashScreenManager
extends Node

## This class is used to display a series of splash screens in sequence.

## Emits when all scenes are finished rendering
signal all_finished

## Emits when a splash screen is finished rendering
signal screen_finished(splash_screen)

## An array of PackedScenes that represent the splash screens to be displayed, in order.
## The splash screens must be of type SplashScreen.
@export var splash_screens : Array[PackedScene]

func display_all_splash() -> void:
	if splash_screens.size() == 0:
		all_finished.emit()
		return
	
	var curr_scene = splash_screens.pop_front()
	while(curr_scene):
		var splash_screen = curr_scene.instantiate()
		await display_splash(splash_screen)
		curr_scene = splash_screens.pop_front()
	all_finished.emit()

func display_splash(splash_screen : SplashScreen) -> void:
	assert(splash_screen is SplashScreen, "Splash screen must be of type SplashScreen")
	add_child(splash_screen)
	await splash_screen.finished
	screen_finished.emit(splash_screen)
	splash_screen.queue_free()
