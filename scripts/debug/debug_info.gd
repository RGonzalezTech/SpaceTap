class_name DebugInfo
extends Object

static func get_version() -> String:
	var version_file_path = "res://VERSION.txt"
	var version_exists = FileAccess.file_exists(version_file_path)
	
	if(version_exists):
		return FileAccess.get_file_as_string(version_file_path)
	else:
		return "VERSION.txt not found"
