extends Label

func _ready():
	var version = DebugInfo.get_version()
	self.text = version
