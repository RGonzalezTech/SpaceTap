class_name GameStateManagerCode
extends Node

var active_level : Level

## The GameStateManager will store the main menu scene
## so that we can always return to the main menu
var main_menu_scene : PackedScene

func is_level_active():
	return (active_level != null)

func go_main_menu() -> void:
	if(!main_menu_scene):
		return

	var tree_root = get_tree()
	tree_root.paused = false
	tree_root.change_scene_to_packed(main_menu_scene)

func quit_graceful():
	# TODO: handle saving game state
	quit_immediate()

func quit_immediate():
	get_tree().quit()
