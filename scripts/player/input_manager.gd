class_name InputManager
extends Node

## The input manager is responsible for handling direct user inputs
## and emitting signals to report the player's intentions to the game.
## It can be used to handle keyboard, mouse, and gamepad inputs.

## The signal emitted when the player wants to jump.
signal jumped

## The signal emitted when the player wants to pause / cancel an action.
signal cancel

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	# This is currently managed by Godot itself, but we could add
	# custom input handling here if we wanted to.
	if(event.is_action_pressed("jump")):
		jumped.emit()
	
	if(event.is_action_pressed("cancel")):
		cancel.emit()
