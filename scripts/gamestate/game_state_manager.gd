class_name GameStateManagerCode
extends Node

enum GameState {
	MAIN_MENU,
	PLAYING,
	GAME_OVER
}

var current_state : GameState = GameState.MAIN_MENU
var active_level : Level

## The GameStateManager will store the main menu scene
## so that we can always return to the main menu
var main_menu_scene : PackedScene

func _ready():
	# The code in this class should always run
	process_mode = Node.PROCESS_MODE_ALWAYS

## This function will undo any game-state changes
## like pausing the code or time
func reset_environment():
	# Self-managed states
	current_state = GameState.MAIN_MENU
	active_level = null

	# Engine states
	Engine.time_scale = 1
	get_tree().paused = false

func is_level_active():
	return (active_level != null)

func go_main_menu() -> void:
	if(!main_menu_scene):
		return

	get_tree().change_scene_to_packed(main_menu_scene)
	await get_tree().tree_changed # wait before updating states
	GameStateManager.reset_environment()

## Reloads the active scene if it is a [Level]
func restart_level() -> void:
	if(!active_level):
		return

	get_tree().reload_current_scene()

func quit_graceful():
	# TODO: handle saving game state
	quit_immediate()

func quit_immediate():
	get_tree().quit()
