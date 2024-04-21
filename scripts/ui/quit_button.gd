class_name GameQuitButton
extends Button

func _pressed():
    GameStateManager.quit_graceful()