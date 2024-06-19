class_name GameOverUI
extends BaseUI

@export var quit_btn : Button
@export var restart_btn : Button

func _ready():
    assert(quit_btn, "[GameOverUI]: quit_btn is required")
    assert(restart_btn, "[GameOverUI]: restart_btn is required")

    quit_btn.pressed.connect(_on_quit)
    restart_btn.pressed.connect(_on_restart)

func _on_quit():
    GameStateManager.go_main_menu()

func _on_restart():
    # Restart the current level
    GameStateManager.restart_level()