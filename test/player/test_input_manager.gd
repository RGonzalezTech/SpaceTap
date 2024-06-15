extends GutTest

var manager : InputManager
var sender

func before_each():
	manager = add_child_autofree(InputManager.new())
	watch_signals(manager)

	sender = InputSender.new(manager)

func after_each():
	sender.release_all()
	sender.clear()

func test_emits_jump_signal_on_jump_action():
	assert_signal_not_emitted(manager, "jumped")
	sender.action_down("jump")
	assert_signal_emitted(manager, "jumped")

func test_emits_cancel_signal_on_cancel_action():
	assert_signal_not_emitted(manager, "cancel")
	sender.action_down("cancel")
	assert_signal_emitted(manager, "cancel")
