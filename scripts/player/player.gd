class_name Player
extends RigidBody2D

signal died(obstacle: BaseObstacle)

@export var jump_strength : int = 600

var input_manager : InputManager

func _ready():
	_subscribe_to_inputs()
	_subscribe_to_physics()

# Private methods
func _subscribe_to_inputs() -> void:
	# User Inputs
	input_manager = InputManager.new()
	input_manager.jumped.connect(_on_jumped)
	add_child(input_manager)

func _subscribe_to_physics() -> void:
	self.max_contacts_reported = 1
	self.contact_monitor = true
	self.body_entered.connect(_on_body_entered)

# Listeners
## This function is called when the player's input manager emits the "jumped" signal
func _on_jumped() -> void:
	# Jump with a maximum velocity of jump_strength
	self.linear_velocity.y = jump_strength * -1

## This function is called when the player touches a physics body. If the body is an obstacle, the player dies
func _on_body_entered(body: Node) -> void:
	if body is BaseObstacle:
		died.emit(body)
