class_name SplashScreen
extends Node

## This node represents a splash screen that can be used to display a logo or any other image before the game starts.

## Emitted when the splash screen is ready to be removed.
signal finished

## Emits the finished signal.
func finish():
	finished.emit()
