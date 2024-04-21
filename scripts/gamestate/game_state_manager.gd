class_name GameStateManagerCode
extends Node

var active_level : Level

func is_level_active():
	return (active_level != null)

func quit_graceful():
	# TODO: handle saving game state
	quit_immediate()

func quit_immediate():
	get_tree().quit()