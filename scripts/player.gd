class_name Player
extends RigidBody2D

@export var jump_strength : int = 600

var input_manager : InputManager

func _ready():
	input_manager = InputManager.new()
	input_manager.jumped.connect(_on_jumped)
	add_child(input_manager)
	add_to_group("player")

func _on_jumped() -> void:
	# Jump with a maximum velocity of jump_strength
	self.linear_velocity.y = jump_strength * -1
