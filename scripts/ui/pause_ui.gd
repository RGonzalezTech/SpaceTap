class_name PauseUI
extends BaseUI

@export var resume_btn : Button
@export var quit_btn : Button
@export var popup : PopupPanel

func pause_show():
	# Only try to pause if the player is 
	# actively playing a level
	if(GameStateManager.current_state != GameStateManagerCode.GameState.PLAYING):
		return
	
	get_tree().paused = true
	popup.popup()

func _ready():
	assert(resume_btn, "PauseUI: 'resume_btn' is required")
	assert(quit_btn, "PauseUI: 'quit_btn' is required")
	assert(popup, "PauseUI: 'popup' is required")
	
	_subscribe()

func _subscribe() -> void:
	resume_btn.pressed.connect(_on_resume)
	quit_btn.pressed.connect(_on_quit)
	popup.popup_hide.connect(_on_ui_hide)

func _on_resume() -> void:
	popup.hide()

func _on_quit() -> void:
	GameStateManager.go_main_menu()

func _on_ui_hide() -> void:
	get_tree().paused = false
