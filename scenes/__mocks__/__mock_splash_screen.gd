class_name MockSplashScreen
extends SplashScreen

@export var wait_time : float = 0.25

func _ready():
	_trigger_finish()

func _trigger_finish():
	# Wait for a bit before closing the splash screen
	await get_tree().create_timer(wait_time).timeout
	self.finish()
