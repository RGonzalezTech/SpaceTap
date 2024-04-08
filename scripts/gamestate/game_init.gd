class_name GameInit
extends Node

@export var splash_manager : SplashScreenManager
@export var main_menu : PackedScene

signal game_ready

func _ready():
	assert(splash_manager, "SplashScreenManager not set in GameStateManager")
	assert(main_menu, "Main Menu scene required for GameInit")
	splash_manager.all_finished.connect(_on_splash_finish)
	splash_manager.display_all_splash()

func _on_splash_finish() -> void:
	game_ready.emit()
	# Load main menu
	get_tree().change_scene_to_packed(main_menu)
