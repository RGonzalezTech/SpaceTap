class_name InputManager
extends Node

signal jumped

func _input(event):
	if(event.is_action_pressed("jump")):
		jumped.emit()
