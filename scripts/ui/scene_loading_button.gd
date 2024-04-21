class_name SceneLoadingButton
extends Button

@export var scene : PackedScene

func _ready():
	assert(scene, "SceneLoadingButton: 'scene' is not set.")

func _pressed():
	get_tree().change_scene_to_packed(scene)
