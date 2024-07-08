class_name BaseSerializable
extends Node

@export_file() var save_path : String = ""

func _ready():
	_assert_save_path()

## This is a helper function that checks if the save path is set.
func _assert_save_path() -> void:
	assert(self.save_path, "The save path must be set.")
	assert(self.save_path != "", "The save path must not be empty." )

## This function is responsible for preparing the data to be saved,
## and then calling the store_data method to save the data to a file.
func write_save() -> void:
	assert(false, "save method must be implemented by subclasses.")

## This function is responsible for loading the data from a file and parsing it.
func load_save() -> void:
	assert(false, "load method must be implemented by subclasses.")

## This function is responsible for stringifying the data and saving it to a file.
func push_data(data: Variant) -> void:
	_assert_save_path()

	var data_json = JSON.stringify(data)
	var data_file = FileAccess.open(self.save_path, FileAccess.WRITE)
	data_file.store_string(data_json)
	data_file.close()

## This function is responsible for loading the data from a file and parsing it.
func pull_data() -> Variant:
	_assert_save_path()

	var file_exists = FileAccess.file_exists(self.save_path)
	if(not file_exists):
		# If the file does not exist,
		# the leaderboard is empty.
		return null

	var file_string = FileAccess.get_file_as_string(self.save_path)
	var json_file = JSON.new()
	var json_result = json_file.parse(file_string)
	if(json_result != OK):
		push_error("Error parsing JSON file: ", json_result.error)
		return null
	return json_file.data

## This class is used to convert objects into JSON strings.
class BaseDTO extends Object:
	static func parse_from(_dictionary: Dictionary) -> BaseDTO:
		# This method must be implemented by subclasses.
		assert(false, "[BaseDTO] parse_from() method must be implemented by subclasses.")
		return BaseDTO.new()

	## This method must be implemented by subclasses.
	## It is used to convert the object into a dictionary that can be converted into a JSON string.
	func values() -> Dictionary:
		# This method must be implemented by subclasses.
		assert(false, "[BaseDTO] values() method must be implemented by subclasses.")
		return {}
	
	static func validate_properties(dictionary: Dictionary, properties: Array[String]) -> void:
		for prop in properties:
			assert(prop in dictionary, "[BaseDTO] Property " + prop + " is required.")
